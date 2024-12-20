import Foundation
import Moya


protocol BannerDataSource {
    func banners(type: BannerType) async throws -> [BannerResponseDTO]
    func bannerImage(filePath: String) async throws -> URL
}


struct DefaultBannerDataSource: BannerDataSource {
    
    private let provider = Provider<BannerAPI>()
    
    
    func banners(type: BannerType) async throws -> [BannerResponseDTO] {
//        Logger().debug("📡 BannerDataSource 요청 시작 - type: \(type.rawValue)")
        let response: [BannerResponseDTO] = try await provider.request(.banners(type: type.rawValue))
//        Logger().debug("✅ 응답 완료 - 필터링된 배너 데이터: \(response)")
        return response
    }
    
    func bannerImage(filePath: String) async throws -> URL {
//        Logger().debug("📡 [BannerDataSource] 요청 시작 - filePath: \(filePath)")
        do {
            // Provider 확장 사용
            let responseString: String = try await provider.requestString(.bannerImage(filePath: filePath))
//            Logger().debug("✅ [BannerDataSource] 응답받은 Presigned URL: \(responseString)")
            
            // String을 URL로 변환
            guard let url = URL(string: responseString) else {
//                Logger().error("❌ [BannerDataSource] URL 변환 실패: \(responseString)")
                throw URLError(.badURL)
            }
            return url
        } catch {
//            Logger().error("❌ [BannerDataSource] 배너 이미지 조회 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
