//
//  AuthAPI.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

enum AuthAPI: BaseTargetType {
    
    case login(LoginRequestDTO)
    case join(req: JoinRequestDTO, platform: String)
    
    var basePath: String {
        return "/auth/oauth2/"
    }
    
    var path: String {
        switch self {
        case .login: return basePath + "login"
        case .join(_, let platform): return basePath + "join/\(platform)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .join:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let req): 
            return .requestParameters(
                parameters: req.toDictionary(),
                encoding: URLEncoding.default
            )
        case .join(let req, _):
            return .requestParameters(parameters: req.toDictionary(), encoding: URLEncoding(boolEncoding: .literal))
        }
    }
    
}
