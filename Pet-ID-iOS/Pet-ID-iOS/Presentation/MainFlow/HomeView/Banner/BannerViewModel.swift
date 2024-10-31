import Combine
import SwiftUI
import Moya

class BannerViewModel: ObservableObject {
    private let provider: MoyaProvider<BannerAPI>
    
    @Published var banners: [Banner] = []
    @Published var error: Error?
    @Published var currentPage: Int = 0
    
    // 주입 가능한 생성자 추가
    init(provider: MoyaProvider<BannerAPI> = MoyaProvider<BannerAPI>()) {
        self.provider = provider
    }
    
    func fetchBanners(type: String) {
        provider.request(.getBanners(type: type)) { result in
            switch result {
            case .success(let response):
                let responseData = String(data: response.data, encoding: .utf8)
                print("서버 응답 데이터: \(responseData ?? "데이터 없음")")
                
                if (200...299).contains(response.statusCode) {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase  // 키 변환 설정 추가
                        let banners = try decoder.decode([Banner].self, from: response.data)
                        //                        let banners = try JSONDecoder().decode([Banner].self, from: response.data)
                        DispatchQueue.main.async {
                            self.banners = banners
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.error = error
                            print("디코딩 오류: \(error.localizedDescription)")
                        }
                    }
                } else {
                    if response.statusCode == 401 || response.statusCode == 403{
                        print("토큰이 만료되었습니다. 토큰을 갱신해야 합니다.")
                        // 토큰 갱신 로직
                    } else {
                        print("배너 API 에러: 상태 코드 \(response.statusCode)")
                    }
                }
            case .failure(let moyaError):
                let logger = Logger()
                logger.error("Moya 에러: \(moyaError.localizedDescription)")
                DispatchQueue.main.async {
                    self.error = moyaError
                }
            }
        }
    }
}
