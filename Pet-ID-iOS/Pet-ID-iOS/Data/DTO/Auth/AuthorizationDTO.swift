//
//  AuthorizationDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

// 사용자 인증 정보를 위한 데이터 전송 객체
struct AuthorizationDTO: Codable{
    // 액세스 토큰
    var accessToken: String
    // 리프레시 토큰
    var refreshToken: String
    
    // DTO를 도메인 모델로 변환
    // Returns: Authorization 도메인 모델
    func toDomain() -> Authorization {
        return .init(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
