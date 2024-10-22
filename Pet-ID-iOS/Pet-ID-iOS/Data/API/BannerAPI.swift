
import Moya

enum BannerAPI {
    case getBanners(type: String)
}

extension BannerAPI: BaseTargetType {
    var baseURL: URL {
        return URL(string: "http://yourpet-id.com:8080")!
    }
    
    var path: String {
        switch self {
        case .getBanners(let type):
            return "/v1/banner/type"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getBanners(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
        }
    }
    
//    var headers: [String: String]? {
//        do {
//            let authorization: Authorization = try DefaultAuthRepository().getAuthorizationFromKeychain()
//            print("------------------------\(authorization)")
//            return ["Authorization": "Bearer \(authorization.accessToken)"]
//            
//        } catch {
//            print("Authorization 헤더 추가 실패: \(error.localizedDescription)")
//            return nil
//        }
//    }
}
