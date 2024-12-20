////
////  TestAPI.swift
////  Pet-ID-iOS
////
////  Created by 박호건 on 11/14/24.
////
//
//import Foundation
//import Moya
//
//enum TestAPI {
//    case imageURL(filePath: String)
//}
//
//extension TestAPI: BaseTargetType {
//    var path: String {
//        switch self {
//        case .imageURL:
//            return "/v1/banner/presigned-get-url"
//        }
//    }
//    
//    var method: Moya.Method {
//        return .get
//    }
//    
//    var task: Moya.Task {
//        switch self {
//        case .imageURL(let filePath):
//            let parameters = ["filePath": filePath]
//            
//            // URL에 전달할 파라미터 로깅
//            Logger().debug("🔗 요청 파라미터: \(parameters)")
//            
//            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
//        }
//    }
//    
//    
//    
//    
//}
