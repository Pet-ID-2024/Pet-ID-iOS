import Moya

// API 타겟 정의
enum BannerAPI {
    case getBanners(type: String)
//    case getPresignedUrl(type: String)
}

// Moya TargetType 구현
extension BannerAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://yourpet-id.com:8080")!
    }
    
    var path: String {
        switch self {
        case .getBanners:
            return "/v1/banner/type"
//        case .getPresignedUrl:
//            return "/v1/banner/presigned-get-url"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBanners:
            return .get
//        case .getPresignedUrl:
//            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getBanners(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
//        case .getPresignedUrl(let imagePath):
//                    return .requestParameters(parameters: ["imagePath": imagePath], encoding: URLEncoding.default)
        }
    }
    
    
    var headers: [String: String]? {
        do {
            let authorization: Authorization = try DefaultAuthRepository().fetchAuthTokensFromKeychainSync()
            print("Fetched access token: \(authorization.accessToken)")
            return ["Authorization": "Bearer \(authorization.accessToken)"]
        } catch {
            print("Error fetching access token: \(error)")
            return nil
        }
    }
}

