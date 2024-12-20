//
//  PetIDAPI.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/18/24.
//

import Foundation
import Moya

enum PetIDAPI {
    case registerType(request: PetIDRequestDTO)
}

extension PetIDAPI: BaseTargetType {
    var path: String {
        return "/v1/pet"
    }
    
    var method: Moya.Method {
        switch self {
        case .registerType:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .registerType(let req):
            Logger().debug("📡 서버로 보낼 요청: \(req)")
            return .requestJSONEncodable(req)
        }
    }
}
