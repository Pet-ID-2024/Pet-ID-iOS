//
//  ReservationTimeAPI.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/7/24.
//

import Foundation
import Moya

enum ReservationTimeAPI: BaseTargetType {
    case availableTimes(hospitalId: Int, day: String, date: String)
    
    var path: String {
        switch self {
        case .availableTimes:
            return "/v1/hospital/order/time"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .availableTimes:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .availableTimes(let hospitalId, let day, let date):
            let parameters: [String: Any] = [
                "hospitalId": hospitalId,
                "day": day,
                "date": date
            ]
            
//            print("ReservationTimeAPI 요청 파라미터: \(parameters)")
//            print("ReservationTimeAPI 요청 경로: \(baseURL)\(path)")
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    
    
}
