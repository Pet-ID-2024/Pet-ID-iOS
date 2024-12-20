import Foundation


struct DefaultBannerRepository: BannerRepository {
    
    let dataSource: BannerDataSource
    
    init(dataSource: BannerDataSource = DefaultBannerDataSource()) {
        self.dataSource = dataSource
    }
    
    func banners(type: BannerType) async throws -> [Banner] {
        do {
            let banners = try await dataSource.banners(type: type)
                .map { $0.toDomain() }
            return banners
        } catch {
            Logger().error("❌ 배너 가져오기 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    func bannerImage(filePath: String) async throws -> URL {
        return try await dataSource.bannerImage(filePath: filePath)
    }
}
