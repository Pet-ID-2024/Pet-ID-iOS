//
//  AuthAPI.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

// 사용자 인증 API를 정의하는 열거형
enum AuthAPI: BaseTargetType {
    
    static let basePath = "/auth/oauth2/"
    
    // 로그인 요청
    case login(LoginRequestDTO)
    // 회원가입 요청
    case join(req: JoinRequestDTO, platform: String)
    // 토큰 갱신 요청
    case refresh(req: TokenRefreshRequestDTO)
    
    // API 경로 정의
    var path: String {
        switch self {
        case .login: return Self.basePath + "login"
        case .join(_, let platform): return Self.basePath + "join/\(platform)"
        case .refresh: return "/auth/token/refresh"
        }
    }
    
    // HTTP 메서드를 정의
    var method: Moya.Method {
        switch self {
        case .login, .join, .refresh:
            return .post
        }
    }
    
    // 요청의 작업 유형을 정의
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
