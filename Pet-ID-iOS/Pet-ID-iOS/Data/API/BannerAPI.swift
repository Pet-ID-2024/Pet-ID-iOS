import Moya

enum BannerAPI {
    case getBanners(type: String)
    case getBannerImageURL(filePath: String)
}

extension BannerAPI: BaseTargetType {
    var baseURL: URL {
        return URL(string: "http://yourpet-id.com:8080")!
    }
    
    var path: String {
        switch self {
        case .getBanners(let type):
            return "/v1/banner/type"
        case .getBannerImageURL:
            return "/v1/banner/presigned-get-url"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getBanners(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
        case .getBannerImageURL(let filePath):
            return .requestParameters(parameters: ["filePath": filePath], encoding: URLEncoding.default)
        }
    }
}
