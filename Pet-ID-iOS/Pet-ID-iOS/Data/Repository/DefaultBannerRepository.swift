import Foundation

struct DefaultBannerRepository: BannerRepository {
    
    let dataSource: BannerDataSource
    
    init(dataSource: BannerDataSource = DefaultBannerDataSource()) {
        self.dataSource = dataSource
    }
    
    func getBanners(type: String) async throws -> [Banner] {
        try await dataSource.getBanners(type: type)
            .map { $0.toDomain() }
    }
}
