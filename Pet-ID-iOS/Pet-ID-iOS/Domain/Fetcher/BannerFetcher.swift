import Foundation

protocol BannerFetcher {
    func getBanners(type: String) async throws -> [Banner]
}

struct DefaultBannerFetcher: BannerFetcher {
    
    private let repository: BannerRepository
    
    init(
        repository: BannerRepository = DefaultBannerRepository()
    ) {
        self.repository = repository
    }
    
    func getBanners(type: String) async throws -> [Banner] {
        try await repository.getBanners(type: type)
    }
}
