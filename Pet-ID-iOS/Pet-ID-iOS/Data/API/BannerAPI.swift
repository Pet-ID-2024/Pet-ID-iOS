////
////  BannerAPI.swift
////  Pet-ID-iOS
////
////  Created by 박호건 on 8/22/24.
////
//
//import Foundation
//import Moya
//
//
//// Define the BannerAPI enum
//enum BannerAPI: TargetType {
//    case createBanner(BannerModel)
//    case updateBanner(id: Int, banner: BannerModel)
//    case deleteBanner(id: Int)
//    case getBannersByType(type: String)
//    case getPresignedGetUrl(filePath: String)
//    case getPresignedPutUrl(filePath: String)
//
//    var baseURL: URL {
//        return URL(string: "http://43.203.1.26:8080/v1")!
//    }
//
//    var path: String {
//        switch self {
//        case .createBanner:
//            return "/banner"
//        case .updateBanner(let id, _):
//            return "/banner/\(id)"
//        case .deleteBanner(let id):
//            return "/banner/\(id)"
//        case .getBannersByType:
//            return "/banner/type"
//        case .getPresignedGetUrl:
//            return "/banner/presigned-get-url"
//        case .getPresignedPutUrl:
//            return "/banner/presigned-put-url"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .createBanner:
//            return .post
//        case .updateBanner:
//            return .put
//        case .deleteBanner:
//            return .delete
//        case .getBannersByType:
//            return .get
//        case .getPresignedGetUrl:
//            return .get
//        case .getPresignedPutUrl:
//            return .post
//        }
//    }
//
//    var task: Task {
//        switch self {
//        case .createBanner(let banner):
//            return .requestJSONEncodable(banner)
//        case .updateBanner(_, let banner):
//            return .requestJSONEncodable(banner)
//        case .deleteBanner:
//            return .requestPlain
//        case .getBannersByType(let type):
//            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
//        case .getPresignedGetUrl(let filePath), .getPresignedPutUrl(let filePath):
//            return .requestParameters(parameters: ["filePath": filePath], encoding: URLEncoding.default)
//        }
//    }
//
//    var headers: [String: String]? {
//        return ["Authorization": "test", "Content-Type": "application/json"]
//    }
//}
