//
//  LoginUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

protocol LoginUseCase {
    func execute(oauth: OAuth, fcmToken: String) async -> Result<Bool, NetworkError>
}

struct DefaultLoginUseCase: LoginUseCase {
    private let authRepository: AuthRepository
    
    init(
        authRepository: AuthRepository = DefaultAuthRepository()
    ) {
        self.authRepository = authRepository
    }
    
    func execute(oauth: OAuth, fcmToken: String) async -> Result<Bool, NetworkError> {
        let result = await authRepository.login(oauth: oauth, fcmToken: fcmToken)
        
        switch result {
        
        case .success(let authorization):
            
            let result = authRepository.storeAuthorizationToKeychain(auth: authorization)
            
            return .success(result)
        
        case .failure(let error):
            
            return .failure(error)
        }
    }
}
