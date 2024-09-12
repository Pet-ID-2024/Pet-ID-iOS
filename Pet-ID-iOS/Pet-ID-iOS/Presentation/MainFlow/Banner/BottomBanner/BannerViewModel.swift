import Foundation

struct Banner: Identifiable, Codable {
    let id: Int
    let imageUrl: String?
    let text: String?
    let type: String?
    let status: String?
}


import Combine
import Moya

class BannerViewModel: ObservableObject {
    @Published var banners: [Banner] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<BannerAPI>()
    
    func fetchBanners(type: String) {
        isLoading = true
        provider.requestPublisher(.getBanners(type: type))
            .map([Banner].self)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            }, receiveValue: { banners in
                self.banners = banners
            })
            .store(in: &cancellables)
    }
    
    func fetchPresignedUrl(for imagePath: String, completion: @escaping (String?) -> Void) {
        provider.requestPublisher(.getPresignedUrl(imagePath: imagePath))
            .map(String.self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
//                    completion(nil)
                }
            }, receiveValue: { url in
                completion(url)
            })
            .store(in: &cancellables)
    }
}
