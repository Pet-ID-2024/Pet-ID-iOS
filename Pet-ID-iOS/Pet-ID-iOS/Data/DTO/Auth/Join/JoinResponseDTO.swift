//
//  JoinResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

// 사용자 가입 응답을 위한 데이터 전송 객체
struct JoinResponseDTO: Decodable {
    // 액세스 토큰
    var accessToken: String
    // 리프레시 토큰
    var refreshToken: String
    
    // DTO를 도메인 모델로 변환
    // Returns: Authorization 도메인 모델
    func toDomain() -> Authorization {
        return Authorization(
            accessToken: self.accessToken,
            refreshToken: self.refreshToken
        )
    }
}
