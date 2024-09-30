//
//  AuthDataSource.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

// 인증 데이터 소스를 정의하는 프로토콜
protocol AuthDataSource {
    // 로그인 요청 메서드
    func login(req: LoginRequestDTO) async throws -> LoginResponseDTO
    // 회원가입 요청 메서드
    func join(req: JoinRequestDTO, platform: String) async throws -> JoinResponseDTO
    // 토큰 갱신 요청 메서드
    func refresh(req: TokenRefreshRequestDTO) async throws -> AuthorizationDTO
}

// 기본 인증 데이터 소스 구현
struct DefaultAuthDataSource: AuthDataSource {
    // Moya Provider를 사용해 API 요청을 처리
    private let provider: Provider<AuthAPI> = Provider()
    
    // 로그인 요청을 처리
    func login(req: LoginRequestDTO) async throws -> LoginResponseDTO {
        try await self.provider.request(.login(req))
    }
    
    // 회원가입 요청을 처리
    func join(req: JoinRequestDTO, platform: String) async throws -> JoinResponseDTO {
        try await self.provider.request(.join(req: req, platform: platform))
    }
    
    // 토큰 갱신 요청을 처리
    func refresh(req: TokenRefreshRequestDTO) async throws -> AuthorizationDTO {
        try await self.provider.request(.refresh(req: req))
    }
}
