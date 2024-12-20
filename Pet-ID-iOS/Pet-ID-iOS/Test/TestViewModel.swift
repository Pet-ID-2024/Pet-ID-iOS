//import Combine
//import Foundation
//
//enum BannerViewModelState {
//    case loading
//    case success
//    case failure(String)
//}
//
//final class TestViewModel: ObservableObject {
//    @Published var mainBanners: [Banner] = []   // 메인 배너 데이터
//    @Published var contentBanners: [Banner] = [] // 콘텐츠 배너 데이터
//    @Published var state: BannerViewModelState = .loading
//    
//    private let bannerFetcher: BannerFetcher
//    private var cancellables = Set<AnyCancellable>()
//    
//    init(bannerFetcher: BannerFetcher = DefaultBannerFetcher()) {
//        self.bannerFetcher = bannerFetcher
//    }
//    
//    /// 메인 배너 데이터 로드
//    func loadMainBanners() {
//        loadBanners(type: .main) { [weak self] banners in
//            self?.mainBanners = banners
//        }
//    }
//    
//    /// 콘텐츠 배너 데이터 로드
//    func loadContentBanners() {
//        loadBanners(type: .content) { [weak self] banners in
//            self?.contentBanners = banners
//        }
//    }
//    
//    /// 배너 데이터 공통 로직
//    private func loadBanners(type: BannerType, completion: @escaping ([Banner]) -> Void) {
//        state = .loading
//        Task {
//            do {
//                let banners = try await bannerFetcher.banners(type: type)
//                var updatedBanners = [Banner]()
//                
//                for banner in banners {
//                    let updatedBanner = try await updateImageURL(for: banner)
//                    updatedBanners.append(updatedBanner)
//                }
//                
//                DispatchQueue.main.async {
//                    completion(updatedBanners)
//                    self.state = .success
//                }
//            } catch {
//                Logger().error("❌ \(type.rawValue) 배너 로드 실패: \(error.localizedDescription)")
//                DispatchQueue.main.async {
//                    self.state = .failure("Failed to load \(type.rawValue) banners")
//                }
//            }
//        }
//    }
//    
//    /// Presigned URL로 배너 이미지 업데이트
//    private func updateImageURL(for banner: Banner) async throws -> Banner {
//        var updatedBanner = banner
//        if let filePath = banner.imageUrl, !filePath.isEmpty {
//            let presignedURL = try await bannerFetcher.bannerImage(filePath: filePath)
//            updatedBanner.imageUrl = presignedURL.absoluteString
//        }
//        return updatedBanner
//    }
//}
