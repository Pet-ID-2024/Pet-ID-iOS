//
//  AuthDataSource.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

protocol AuthDataSource {
    func login(req: LoginRequestDTO) async -> Result<LoginResponseDTO, NetworkError>
}

struct DefaultAuthDataSource: AuthDataSource {
    private let provider: Provider<AuthAPI> = Provider()
    
    func login(req: LoginRequestDTO) async -> Result<LoginResponseDTO, NetworkError> {
        await self.provider.request(.login(req))
    }
}
