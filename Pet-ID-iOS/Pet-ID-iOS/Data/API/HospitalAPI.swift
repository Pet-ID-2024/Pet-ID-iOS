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
    case getHospitals(sido: Int, sigungu: Int, eupmundong: Int, lat: Double, lon: Double)
    case getHospitalDetail(hospitalId: Int)
    case hospitalImage(filePath: String)
    
    
    var path: String {
        switch self {
        case .hospitals:
            return "/v1/hospital"
        case .getHospitals:
            return "/v1/hospital/location"
        case .getHospitalDetail(let hospitalId):
            return "/v1/hospital/\(hospitalId)"
        case .hospitalImage:
            return "/v1/hospital/images/presigned-url"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .hospitals, .getHospitals, .hospitalImage, .getHospitalDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .hospitals(let sidoId, let sigunguId, let eupmundongId):
            let parameters: [String: Any] = [
                "sido": sidoId,
                "sigungu": sigunguId,
                "eupmundong": eupmundongId ?? ""
            ]
//            print("HospitalAPI 요청 파라미터 : \(parameters)")
//            print("HospitalAPI 요청 경로: \(baseURL)\(path)")
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .getHospitals(let sido, let sigungu, let eupmundong, let lat, let lon):
            let parameters: [String: Any] = [
                "sido": sido,
                "sigungu": sigungu,
                "eupmundong": eupmundong,
                "lat": lat,
                "lon": lon
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .hospitalImage(let filePath):
            let cleanFilePath = filePath.removingPercentEncoding ?? filePath
            return .requestParameters(parameters: ["filePath": cleanFilePath], encoding: URLEncoding.queryString)
            
        case .getHospitalDetail(let hospitalId):
            return .requestPlain
        }
    }
}

