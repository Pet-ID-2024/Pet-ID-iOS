import Combine
import SwiftUI
import Moya

class BannerViewModel: ObservableObject {
    private let provider = MoyaProvider<BannerAPI>()
    
    @Published var banners: [Banner] = []
    @Published var error: Error?
    @Published var currentPage: Int = 0
    
    func fetchBanners(type: String) {
        provider.request(.getBanners(type: type)) { result in
            switch result {
            case .success(let response):
                let responseData = String(data: response.data, encoding: .utf8)
                print("서버 응답 데이터: \(responseData ?? "데이터 없음")")
                // 200대 상태 코드인지 확인
                if (200...299).contains(response.statusCode) {
                    do {
                        let banners = try JSONDecoder().decode([Banner].self, from: response.data)
                        DispatchQueue.main.async {
                            self.banners = banners
                            // self.fetchBannerImages() // 배너 이미지 가져오기
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.error = error
                            print("디코딩 오류: \(error.localizedDescription)")
                        }
                    }
                } else {
                    // 401이나 다른 에러 처리
                    if response.statusCode == 401 {
                        print("토큰이 만료되었습니다. 토큰을 갱신해야 합니다.")
                        // 토큰 갱신 로직 호출 또는 에러 처리
                    } else {
                        print("배너 API 에러: 상태 코드 \(response.statusCode)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                    print("서버 요청 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
