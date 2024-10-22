import XCTest
import Combine
@testable import Pet_ID_iOS


class MockBannerRepository: BannerRepository {
    var shouldFailWithTokenError = false

    func getBanners(type: String) async throws -> [Banner] {
        if shouldFailWithTokenError {
            throw NetworkError.underlying(statusCode: 401, response: Response(statusCode: 401, data: Data()))
        }

        return [
            Banner(id: 1, imageUrl: "https://example.com/banner1.png", text: "Banner 1", type: "main", status: "active"),
            Banner(id: 2, imageUrl: "https://example.com/banner2.png", text: "Banner 2", type: "content", status: "active")
        ]
    }
}
