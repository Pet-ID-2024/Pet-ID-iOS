//
//  HospitalAPI.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation
import Moya


enum HospitalAPI: BaseTargetType {
    case hospitals(sido: Int, sigunguId: Int, eupmundong: Int?)
    
    
    var path: String {
        return "/v1/hospital"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .hospitals(let sidoId, let sigunguId, let eupmundongId):
            var parameters: [String: Any] = [
                "sido": sidoId,
                "sigungu": sigunguId,
            ]
            if let eupmundongId = eupmundongId{
                parameters["eupmundong"] = eupmundongId
            }
            print("HospitalAPI 요청 파라미터 : \(parameters)")
            print("HospitalAPI 요청 경로: \(baseURL)\(path)")
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}

