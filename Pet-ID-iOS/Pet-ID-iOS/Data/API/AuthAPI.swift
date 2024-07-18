//
//  AuthAPI.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

enum AuthAPI: BaseTargetType {
    
    static let basePath = "/auth/oauth2/"
    
    case login(LoginRequestDTO)
    case join(req: JoinRequestDTO, platform: String)
    case refresh(req: TokenRefreshRequestDTO)
    
    var path: String {
        switch self {
        case .login: return Self.basePath + "login"
        case .join(_, let platform): return Self.basePath + "join/\(platform)"
        case .refresh: return "/auth/token/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .join, .refresh:
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
        case .refresh(let req):
            return .requestParameters(parameters: req.toDictionary(), encoding: URLEncoding.default)
        }
    }
    
}
