//
//  JoinUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

/// 가입 사용 사례를 위한 프로토콜
protocol JoinUseCase {
    /// 사용자가 가입하는 메서드
    /// - Parameters:
    ///   - oauth: OAuth 인증 정보를 포함한 객체
    ///   - fcmToken: Firebase Cloud Messaging 토큰
    ///   - agreedAd: 광고 수신 동의 여부
    /// - Throws: 가입 실패 시 오류를 발생시킴
    func execute(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws
}

/// 기본 구현체로, 사용자의 가입을 처리합니다.
struct DefaultJoinUseCase: JoinUseCase {
    
    let authRepository: AuthRepository // 인증 관련 저장소
    
    init(
        authRepository: AuthRepository = DefaultAuthRepository()
    ) {
        self.authRepository = authRepository // 기본 인증 저장소를 주입합니다.
    }
    
    /// 사용자가 가입을 실행
    /// - Parameters:
    ///   - oauth: OAuth 인증 정보
    ///   - fcmToken: FCM 토큰
    ///   - agreedAd: 광고 수신 동의 여부
    /// - Throws: 가입 중 발생할 수 있는 오류
    func execute(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws {
        // OAuth를 사용하여 사용자를 가입 처리
        let authorization = try await authRepository.join(oauth: oauth, fcmToken: fcmToken, agreedAd: agreedAd)
    }
}
