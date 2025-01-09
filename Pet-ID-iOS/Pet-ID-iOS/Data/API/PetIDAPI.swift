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
    case deletePet(petId: Int)
}

extension PetIDAPI: BaseTargetType {
    var path: String {
        switch self {
        case .registerType:
            return "/v1/pet"
        case .deletePet(let petId):
            return "/v1/pet/\(petId)"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .registerType:
            return .post
        case .deletePet:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .registerType(let req):
            Logger().debug("📡 서버로 보낼 요청: \(req)")
            return .requestJSONEncodable(req)
        case .deletePet:
            return .requestPlain
        }
    }
}
