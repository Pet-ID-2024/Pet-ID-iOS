import Foundation

enum PetBlogDetailState {
    case back
    case showDetail(blog: Blog)
}

final class PetBlogDetailViewModel: BaseViewModel<PetBlogDetailState> {
    @Published var blog: Blog
    @Published var recommendedBlogs: [Blog] = []
    private let blogFetcher: BlogFetcher
    @Published private(set) var isLikedByUser: Bool
    @Published var isPresentingShareSheet = false
    @Published var shareItems: [Any] = []
    
    // 좋아요 상태 변경 전파를 위한 publisher
    let likeUpdatePublisher = ResultPublisher<(Int, Bool, Int)>()
    
    init(blog: Blog, blogFetcher: BlogFetcher = DefaultBlogFetcher()) {
        self.blog = blog
        self.blogFetcher = blogFetcher
        self.isLikedByUser = blog.isLiked
        
        super.init()
        
        // 서버에서 최신 블로그 데이터를 가져와 초기화
        Task {
            await loadLatestBlogData()
            await loadRecommendBlogs()
            await updateImageURL()
        }
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func prepareToShare() {
        shareItems = [blog.title, blog.body]
        isPresentingShareSheet = true
    }
    
    func toggleLike() async {
        do {
            if isLikedByUser {
                let response = try await blogFetcher.unlikeContent(contentId: blog.contentId)
                updateBlogState(isLiked: false, likesCount: response.likeCount)
            } else {
                let response = try await blogFetcher.likeContent(contentId: blog.contentId)
                updateBlogState(isLiked: true, likesCount: response.likeCount)
            }
            // 좋아요 상태 동기화
            await loadLatestBlogData()
        } catch {
            Logger().error("좋아요 상태 변경 요청 실패: \(error.localizedDescription)")
        }
    }
    
    func loadLatestBlogData() async {
        do {
            let latestBlogs = try await blogFetcher.blog(category: blog.category)
            if let latestBlog = latestBlogs.first(where: { $0.contentId == blog.contentId }) {
                DispatchQueue.main.async { [weak self] in
                    self?.blog = latestBlog
                    self?.isLikedByUser = latestBlog.isLiked
                }
            }
        } catch {
            Logger().error("최신 블로그 데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    func updateImageURL() async {
        guard !blog.imageUrl.isEmpty else { return } // 이미지 URL이 비어있는 경우 처리하지 않음
        do {
            let presignedURL = try await blogFetcher.contentImage(filePath: blog.imageUrl)
            DispatchQueue.main.async { [weak self] in
                self?.blog.imageUrl = presignedURL.absoluteString
                Logger().debug("✅ 블로그 이미지 URL 업데이트 완료: \(presignedURL)")
            }
        } catch {
            Logger().error("❌ 블로그 이미지 URL 업데이트 실패: \(error.localizedDescription)")
        }
    }
    
    func loadRecommendBlogs() async {
        do {
            let allBlogs = try await blogFetcher.blog(category: blog.category)
            let filteredBlogs = allBlogs.filter { $0.contentId != blog.contentId }
            let randomBlogs = filteredBlogs.shuffled().prefix(3)
            
            // Presigned URL 처리
            let updatedBlogs = try await withThrowingTaskGroup(of: Blog.self) { group in
                for blog in randomBlogs {
                    group.addTask {
                        var updatedBlog = blog
                        if !blog.imageUrl.isEmpty {
                            let presignedURL = try await self.blogFetcher.contentImage(filePath: blog.imageUrl)
                            updatedBlog.imageUrl = presignedURL.absoluteString
                        }
                        return updatedBlog
                    }
                }
                return try await group.reduce(into: [Blog]()) { result, blog in
                    result.append(blog)
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.recommendedBlogs = updatedBlogs
                Logger().debug("✅ 추천 블로그 로드 완료 - 총 추천 블로그 수: \(updatedBlogs.count)")
            }
        } catch {
            Logger().error("❌ 추천 블로그 데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    private func updateBlogState(isLiked: Bool, likesCount: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.isLikedByUser = isLiked
            self.blog.likesCount = likesCount
            self.likeUpdatePublisher.send((self.blog.contentId, isLiked, likesCount))
        }
    }
}
