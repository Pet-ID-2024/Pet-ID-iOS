//
//  TokenRefreshRequestDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation

// 토큰 갱신 요청을 위한 데이터 전송 객체(DTO)
struct TokenRefreshRequestDTO: Encodable {
    // 갱신할 토큰
    let refreshToken: String
}
