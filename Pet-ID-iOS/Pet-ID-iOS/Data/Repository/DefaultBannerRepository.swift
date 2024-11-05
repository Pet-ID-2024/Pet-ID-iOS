import Foundation

struct DefaultBannerRepository: BannerRepository {
    
    let dataSource: BannerDataSource
    
    init(dataSource: BannerDataSource = DefaultBannerDataSource()) {
        self.dataSource = dataSource
    }
    
    func getBanners(type: String) async throws -> [Banner] {
        do {
            return try await dataSource.getBanners(type: type)
                .map { $0.toDomain() }
        } catch {
            let logger = Logger()
            logger.error("배너 가져오기 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    func getBannerImageURL(filePath: String) async throws -> String {
        do {
            let url = try await dataSource.getBannerImageURL(filePath: filePath)
            return url
        } catch {
            let logger = Logger()
            logger.error("이미지 URL 가져오기 실패 \(error.localizedDescription)")
            throw error
        }
    }
}
