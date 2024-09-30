//
//  LoginUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

/// 로그인 사용 사례를 위한 프로토콜
protocol LoginUseCase {
    /// 로그인 실행 메서드
    /// - Parameters:
    ///   - oauth: OAuth 인증 정보를 포함한 객체
    ///   - fcmToken: Firebase Cloud Messaging 토큰
    /// - Throws: 로그인 실패 시 오류를 발생시킴
    /// - Returns: 로그인 성공 여부
    func execute(oauth: OAuth, fcmToken: String) async throws -> Bool
}

/// 기본 구현체로, 로그인 사용 사례를 처리합니다.
struct DefaultLoginUseCase: LoginUseCase {
    
    private let authRepository: AuthRepository // 인증 관련 저장소
    
    init(
        authRepository: AuthRepository = DefaultAuthRepository()
    ) {
        self.authRepository = authRepository // 기본 인증 저장소를 주입합니다.
    }
    
    /// 로그인 실행
    /// - Parameters:
    ///   - oauth: OAuth 인증 정보
    ///   - fcmToken: FCM 토큰
    /// - Throws: 로그인 중 발생할 수 있는 오류
    /// - Returns: 로그인 성공 여부
    func execute(oauth: OAuth, fcmToken: String) async throws -> Bool {
        let authorization = try await authRepository.login(oauth: oauth, fcmToken: fcmToken) // OAuth를 사용하여 로그인
        authRepository.deleteAuthorizationFromKeychain() // 기존 인증 정보를 키체인에서 삭제
        let result = authRepository.storeAuthorizationToKeychain(auth: authorization) // 새로운 인증 정보를 키체인에 저장
        return result // 로그인 성공 여부 반환
    }
}
