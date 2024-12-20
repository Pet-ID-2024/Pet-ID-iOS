import Foundation

protocol BannerRepository {
    func banners(type: BannerType) async throws -> [Banner]
    func bannerImage(filePath: String) async throws -> URL
}
