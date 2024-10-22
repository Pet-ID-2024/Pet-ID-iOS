import Foundation

protocol BannerDataSource {
    func getBanners(type: String) async throws -> [BannerResponseDTO]
}

struct DefaultBannerDataSource: BannerDataSource {
    
    private let provider: Provider<BannerAPI> = Provider()
    
    func getBanners(type: String) async throws -> [BannerResponseDTO] {
        try await provider.request(.getBanners(type: type))
    }
}
