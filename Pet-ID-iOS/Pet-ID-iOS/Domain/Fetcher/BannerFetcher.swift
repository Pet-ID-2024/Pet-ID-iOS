import Foundation

protocol BannerFetcher {
    func banners(type: BannerType) async throws -> [Banner]
    func bannerImage(filePath: String) async throws -> URL
}

struct DefaultBannerFetcher: BannerFetcher {
    
    private let repository: BannerRepository
    
    init(
        repository: BannerRepository = DefaultBannerRepository()
    ) {
        self.repository = repository
    }
    
    func banners(type: BannerType) async throws -> [Banner] {
//        Logger().debug("🟢 BannerFetcher 호출 - type: \(type.rawValue)")
        do{
            let banner = try await repository.banners(type: type)
//            Logger().debug("✅ BannerFetcher 응답 완료 - 배너 데이터 수: \(banner.count)")
            return banner
        } catch {
            Logger().error("❌ BannerFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
    
    func bannerImage(filePath: String) async throws -> URL {
//        Logger().debug("🟢 BannerFetcher 호출 - filePath: \(filePath)")
        do {
            let image = try await repository.bannerImage(filePath: filePath)
//            Logger().debug("✅ BannerFetcher 응답 완료 - URL: \(image.absoluteString)")
            return image
        }catch{
//            Logger().error("❌ BannerFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
}
