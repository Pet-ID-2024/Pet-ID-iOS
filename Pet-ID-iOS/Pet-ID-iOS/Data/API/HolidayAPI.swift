//
//  HolidayAPI.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/8/24.
//

import Foundation
import Moya

enum HolidayAPI: BaseTargetType {
    case checkHoliday(holidayId: Int, day: String)
    
    var path: String {
        switch self{
        case .checkHoliday:
            return "/v1/hospital/off"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkHoliday:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .checkHoliday(let hospitalId, let day):
            let parameters: [String: Any] = [
                "hospitalId": hospitalId,
                "day": day
            ]
//            print("HolidayAPI 요청 파라미터: \(parameters)")
//            print("HolidayAPI 요청 경로: \(baseURL)\(path)")
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
}
