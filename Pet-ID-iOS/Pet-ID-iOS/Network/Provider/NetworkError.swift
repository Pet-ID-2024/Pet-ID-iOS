//
//  NetworkError.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

//import Foundation
//import Foundation
//import Moya
//
//enum NetworkError: Error {
//    case moyaError(MoyaError)
//    case invalidResponse(ErrorModel)
//    case underlying(statusCode: Int, response: Response)
//    case shouldRefreshAccessToken
//    case unknown
//    case decodingError
//    
//    init(error: MoyaError) {
//        switch error {
//        case .statusCode(let response):
//            do {
//                let decoder = JSONDecoder()
//                let errorModel = try decoder.decode(ErrorModel.self, from: response.data)
//                self = .invalidResponse(errorModel)
//            } catch {
//                self = .underlying(statusCode: response.statusCode, response: response)
//                // 에러 모델 변경될 때 까지 이거로;;;;;
////                print("NetworkError Catch \(response)")
////                self = .decodingError
//            }
//        default: self = .unknown
//        }
//    }
//}

import Foundation
import Moya

enum NetworkError: Error {
    case moyaError(MoyaError) // MoyaError 그대로 전달
    case invalidResponse(ErrorModel) // 서버에서 에러 응답을 받을 경우
    case underlying(statusCode: Int, response: Response) // 기본 응답 에러
    case shouldRefreshAccessToken // 토큰이 만료되었을 경우
    case unknown // 기타 알 수 없는 에러
    case decodingError // 디코딩 오류

    init(error: MoyaError) {
        switch error {
        case .statusCode(let response):
            do {
                let decoder = JSONDecoder()
                let errorModel = try decoder.decode(ErrorModel.self, from: response.data)
                self = .invalidResponse(errorModel)
            } catch {
                Logger().error("NetworkError - JSON 디코딩 실패: \(error.localizedDescription)")
                self = .underlying(statusCode: response.statusCode, response: response)
            }
        case .underlying(let nsError as NSError, let response):
            if nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorNotConnectedToInternet {
                Logger().error("NetworkError - 인터넷 연결 안 됨: \(nsError.localizedDescription)")
                self = .unknown // 네트워크 연결 오류로 처리
            } else if let response = response {
                self = .underlying(statusCode: response.statusCode, response: response)
            } else {
                self = .moyaError(error) // MoyaError 그대로 전달
            }
        default:
            self = .unknown
        }
    }
}
