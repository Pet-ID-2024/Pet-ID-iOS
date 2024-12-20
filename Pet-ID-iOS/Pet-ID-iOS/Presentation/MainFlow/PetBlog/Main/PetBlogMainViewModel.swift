//
//  PetBlogMainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/9/24.
//

import Combine
import Foundation

enum PetBlogState {
    case detail(blog: Blog)
    case back
}

final class PetBlogMainViewModel: BaseViewModel<PetBlogState> {
    @Published var blogs: [Blog] = [] // 블로그 리스트
    @Published var selectedTabKey: String = "ALL" // 초기 선택된 탭
    @Published var isPresentingShareSheet = false // 공유 시트 상태
    @Published var shareItems: [Any] = [] // 공유할 데이터
    
    let tabs: [(key: String, value: String)] = [
        ("ALL", "전체"),
        ("ABOUTPET", "어바웃펫"),
        ("TIPS", "반려TIP"),
        ("SUPPORT", "지원"),
        ("VENUE", "장소"),
    ]
    
    let blogFetcher: BlogFetcher
    
    init(blogFetcher: BlogFetcher = DefaultBlogFetcher()) {
        self.blogFetcher = blogFetcher
        super.init()
        fetchBlogs(for: selectedTabKey)
    }
    
    // MARK: - 블로그 데이터 로드
    func fetchBlogs(for categoryKey: String) {
        Task {
            do {
                let fetchedBlogs = try await blogFetcher.blog(category: categoryKey)
                
                // Presigned URL 처리
                let updatedBlogs = try await withThrowingTaskGroup(of: Blog.self) { group in
                    for blog in fetchedBlogs {
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
                
                DispatchQueue.main.async {
                    self.blogs = updatedBlogs
                    Logger().debug("✅ 블로그 데이터 로드 완료 - 총 블로그 수: \(updatedBlogs.count)")
                }
            } catch {
                Logger().error("❌ 블로그 데이터 로드 실패: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - 좋아요 업데이트
    func updateLikesCount(for contentId: Int, likesCount: Int) {
        if let index = blogs.firstIndex(where: { $0.contentId == contentId }) {
            blogs[index].likesCount = likesCount
        }
    }
    
    // MARK: - 탭 변경 처리
    func onTabSelected(_ tabKey: String) {
        guard selectedTabKey != tabKey else { return }
        selectedTabKey = tabKey
        fetchBlogs(for: selectedTabKey)
    }
    
    // MARK: - 블로그 선택 처리
    func detail(for blog: Blog) {
        result.send(.detail(blog: blog))
    }
    
    // MARK: - 공유 준비
    func prepareToShare(blog: Blog) {
        shareItems = [blog.title, blog.body]
        isPresentingShareSheet = true
    }
    
    // MARK: - 뒤로가기 처리
    func navigateBack() {
        result.send(.back)
    }
}
