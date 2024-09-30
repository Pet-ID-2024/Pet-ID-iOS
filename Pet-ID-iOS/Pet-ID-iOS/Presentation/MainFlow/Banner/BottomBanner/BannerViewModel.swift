import Foundation
import Moya
import Combine

struct BannerResponse: Codable {
    let banners: [Banner]
}

import Foundation

struct Banner: Codable, Identifiable {
    let id: Int
    var imageUrl: String?
    let text: String?
    let type: String?
    let status: String?
}

// MARK: - BannerViewModel



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
                do {
                    var banners = try JSONDecoder().decode([Banner].self, from: response.data)
                    DispatchQueue.main.async {
                        self.banners = banners
//                        self.fetchBannerImages() // 배너 이미지 가져오기
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.error = error
                        print("디코딩 오류: \(error.localizedDescription)")
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
    
    // 배너 이미지 URL을 가져오는 함수 추가
//    func fetchBannerImages() {
//        for (index, banner) in banners.enumerated() {
//            guard let imageUrl = banner.imageUrl else { continue }
//            provider.request(.getPresignedUrl(type: imageUrl)) { result in
//                switch result {
//                case .success(let response):
//                    let presignedUrl = String(data: response.data, encoding: .utf8)
//                    DispatchQueue.main.async {
//                        self.banners[index].imageUrl = presignedUrl // presigned URL로 이미지 업데이트
//                    }
//                case .failure(let error):
//                    print("이미지 URL 요청 실패: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
}

import Foundation

struct APIError: Decodable, Error {
    let timestamp: Int
    let status: Int
    let error: String
    let path: String
}
