import Foundation

protocol BannerFetcher {
    func getBanners(type: String) async throws -> [Banner]
    func getBannerImageURL(filePath: String) async throws -> String
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
    
    func getBannerImageURL(filePath: String) async throws -> String {
        try await repository.getBannerImageURL(filePath: filePath)
    }
}
