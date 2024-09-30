//
//  NetworkError.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation
import Foundation
import Moya

// 네트워크 요청 중 발생할 수 있는 에러 정의
enum NetworkError: Error {
    case moyaError(MoyaError) // MoyaError
    case invalidResponse(ErrorModel) // 유효하지 않은 응답
    case underlying(statusCode: Int, response: Response) // 기반 에러
    case unknown // 알 수 없는 에러
    case decodingError // 디코딩 에러
    
    // MoyaError를 기반으로 NetworkError를 초기화하는 이니셜라이저
    // error: Moya에서 발생한 에러
    init(error: MoyaError) {
        switch error {
        case .statusCode(let response):
            // 상태 코드 에러 발생 시 응답 데이터로부터 ErrorModel을 디코딩 시도
            do {
                let decoder = JSONDecoder()
                let errorModel = try decoder.decode(ErrorModel.self, from: response.data)
                self = .invalidResponse(errorModel) // 유효하지 않은 응답으로 설정
            } catch {
                self = .underlying(statusCode: response.statusCode, response: response) // 기반 에러로 설정
                // 에러 모델 변경될 때 까지 이거로;;;;;
//                print("NetworkError Catch \(response)")
//                self = .decodingError
            }
        default: self = .unknown // 다른 종류의 에러는 알 수 없는 에러로 설정
        }
    }
}
