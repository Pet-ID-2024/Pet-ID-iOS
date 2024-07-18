//
//  LoginUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

protocol LoginUseCase {
    func execute(oauth: OAuth, fcmToken: String) async throws -> Bool
}

struct DefaultLoginUseCase: LoginUseCase {
    
    private let authRepository: AuthRepository
    
    init(
        authRepository: AuthRepository = DefaultAuthRepository()
    ) {
        self.authRepository = authRepository
    }
    
    func execute(oauth: OAuth, fcmToken: String) async throws -> Bool {
        let authorization = try await authRepository.login(oauth: oauth, fcmToken: fcmToken)
        let result = authRepository.storeAuthorizationToKeychain(auth: authorization)
        return result
    }
}
