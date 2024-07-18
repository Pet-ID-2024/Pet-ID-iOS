//
//  LogoutUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation

protocol LogoutUseCase {
    func execute()
}

struct DefaultLogoutUseCase: LogoutUseCase {
    
    let authRepository: AuthRepository
    
    init(
        authRepository: AuthRepository = DefaultAuthRepository()
    ) {
        self.authRepository = authRepository
    }
    
    func execute() {
        let result = authRepository.deleteAuthorizationFromKeychain()
        
        if result {
            PetIdNotificationCenter.shared.logout.send(())
        }
    }
}
