import Foundation

protocol BannerRepository {
    func getBanners(type: String) async throws -> [Banner]
}
