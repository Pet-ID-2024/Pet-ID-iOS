import Moya
import Foundation

enum BannerAPI: BaseTargetType {
    case banners(type: String)
    case bannerImage(filePath: String)
    
    var path: String {
        switch self {
        case .banners:
            return "/v1/banner/type"
        case .bannerImage:
            return "/v1/banner/presigned-get-url"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .banners, .bannerImage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .banners(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
        case .bannerImage(let filePath):
            let cleanFilePath = filePath.removingPercentEncoding ?? filePath
            return .requestParameters(parameters: ["filePath": cleanFilePath], encoding: URLEncoding.queryString)
        }
    }
}
