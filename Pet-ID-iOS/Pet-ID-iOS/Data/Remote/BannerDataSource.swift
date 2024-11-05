import Foundation

protocol BannerDataSource {
    func getBanners(type: String) async throws -> [BannerResponseDTO]
    func getBannerImageURL(filePath: String) async throws -> String
}

struct DefaultBannerDataSource: BannerDataSource {
    
    private let provider = Provider<BannerAPI>()
    
    func getBanners(type: String) async throws -> [BannerResponseDTO] {
        try await provider.request(.getBanners(type: type))
    }
    
    func getBannerImageURL(filePath: String) async throws -> String {
        let response: PresignedURLResponseDTO = try await provider.request(.getBannerImageURL(filePath: filePath))
        return response.url
    }
}
