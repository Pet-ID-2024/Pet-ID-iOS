//
//  AddressAPI.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation
import Moya

enum AddressAPI: BaseTargetType {
    
    case sido
    case sigungu(sidoId: Int)
    case eupmundong(sigunguId: Int)
    
    
    var path: String {
        switch self {
        case .sido: 
            return "/v1/location"
        case .sigungu(let sidoId):
            return "/v1/location/sido/\(sidoId)/sigungu"
        case .eupmundong(let sigunguId): 
            return "/v1/location/sigungu/\(sigunguId)/eupmundong"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sido, .sigungu, .eupmundong: 
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .sido, .sigungu, .eupmundong:
//            print("AddressAPI 요청 경로: \(baseURL)\(path)")
//            print("AddressAPI 요청 헤더: \(headers ?? [:])")
            return .requestPlain
        }
    }
}
