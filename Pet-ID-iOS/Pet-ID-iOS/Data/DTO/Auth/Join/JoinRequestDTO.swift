//
//  LoginRequestDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

// 사용자 가입 요청을 위한 데이터 전송 객체
struct JoinRequestDTO: Encodable {
    // 사용자 인증 토큰
    let token: String
    // Firebase Cloud Messaging 토큰
    let fcmToken: String
    // 광고 수신 동의 여부
    let ad: Bool
}
