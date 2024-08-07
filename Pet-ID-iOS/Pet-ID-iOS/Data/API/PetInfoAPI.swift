//
//  PetInfoAPI.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/31/24.
//

import Foundation
import Moya

enum PetInfoAPI: BaseTargetType {
    static let basePath = ""
    
    case savePetInfo(PetInfoRequestDTO)
    
    var path: String {
        switch self {
        case .savePetInfo:
            return Self.basePath + "/save"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .savePetInfo:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .savePetInfo(let req):
            return .requestParameters(parameters: req.toDictionary(), encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : Any]? {
        return ["Content-Type": "application/json"]
    }
    
}
