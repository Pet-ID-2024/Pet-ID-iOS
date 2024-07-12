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
    
    var path: String {
        switch self {
        case .login:
            "/auth/oath2/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let req):
            return .requestJSONEncodable(req)
        }
    }
    
}
