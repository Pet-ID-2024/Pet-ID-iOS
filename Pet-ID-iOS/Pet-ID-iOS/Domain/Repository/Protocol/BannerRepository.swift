import Foundation

protocol BannerRepository {
    func getBanners(type: String) async throws -> [Banner]
    func getBannerImageURL(filePath: String) async throws -> String
}
