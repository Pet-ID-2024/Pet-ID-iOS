import Combine
import Foundation

enum BannerState {
    case back
    case goToDetail(Banner)
}

final class BannerViewModel: BaseViewModel<BannerState> {
    @Published var banners: [Banner] = [] // 배너 리스트
    private let bannerFetcher: BannerFetcher
    let type: BannerType
    
    init(bannerFetcher: BannerFetcher = DefaultBannerFetcher(), type: BannerType) {
        self.bannerFetcher = bannerFetcher
        self.type = type
    }
    
    // MARK: - 배너 데이터 로드 함수
    func loadBanners() async {
        do {
            let fetchedBanners = try await bannerFetcher.banners(type: type)
            
            // Task 내부에서 처리
            let updatedBanners = try await withThrowingTaskGroup(of: Banner.self) { group in
                for banner in fetchedBanners {
                    group.addTask {
                        var updatedBanner = banner
                        if let imageUrl = banner.imageUrl, !imageUrl.isEmpty {
                            let presignedURL = try await self.bannerFetcher.bannerImage(filePath: imageUrl)
                            updatedBanner.imageUrl = presignedURL.absoluteString
                        }
                        return updatedBanner
                    }
                }
                
                // 결과를 배열로 수집
                return try await group.reduce(into: [Banner]()) { result, banner in
                    if banner.status.lowercased() == "active" {
                        result.append(banner)
                    }
                }
            }
            
            // 메인 스레드에서 업데이트
            DispatchQueue.main.async {
                self.banners = updatedBanners
//                Logger().debug("✅ 배너 데이터 로드 완료 - 총 배너 수: \(updatedBanners.count)")
            }
        } catch {
            Logger().error("❌ 배너 데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 배너 선택 이벤트 처리
    func onBannerTapped(banner: Banner) {
        Logger().debug("Banner tapped: \(banner)")
        result.send(.goToDetail(banner))
    }
}
