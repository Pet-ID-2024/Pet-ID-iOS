import Moya

enum BannerAPI {
    case getBanners(type: String)
    case getPresignedUrl(imagePath: String)
}

extension BannerAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://yourpet-id.com:8080/v1/banner")!
    }

    var path: String {
        switch self {
        case .getBanners:
            return "/type"
        case .getPresignedUrl:
            return "/presigned-get-url"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getBanners:
            return .get
        case .getPresignedUrl:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .getBanners(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
        case .getPresignedUrl(let imagePath):
            return .requestParameters(parameters: ["imagePath": imagePath], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
