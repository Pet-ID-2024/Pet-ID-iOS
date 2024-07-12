//
//  AutoLoginUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

protocol AutoLoginUseCase {
    func execute() -> AnyPublisher<Bool, Never>
}

struct DefaultAutoLoginUseCase: AutoLoginUseCase {
    
    let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = DefaultAuthRepository()) {
        self.authRepository = authRepository
    }
    
    func execute() -> AnyPublisher<Bool, Never> {
        return authRepository.getAuthorizationFromKeychain()
            .map { _ in true}
            .catch { _ in
                return Just(false)
            }
            .eraseToAnyPublisher()
    }
}
