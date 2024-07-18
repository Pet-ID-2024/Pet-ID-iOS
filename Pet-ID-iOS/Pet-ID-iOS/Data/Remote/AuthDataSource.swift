//
//  AuthDataSource.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

protocol AuthDataSource {
    func login(req: LoginRequestDTO) async throws -> LoginResponseDTO
    func join(req: JoinRequestDTO, platform: String) async throws -> JoinResponseDTO
}

struct DefaultAuthDataSource: AuthDataSource {
    private let provider: Provider<AuthAPI> = Provider()
    
    func login(req: LoginRequestDTO) async throws -> LoginResponseDTO {
        try await self.provider.request(.login(req))
    }
    
    func join(req: JoinRequestDTO, platform: String) async throws -> JoinResponseDTO {
        try await self.provider.request(.join(req: req, platform: platform))
    }
}
