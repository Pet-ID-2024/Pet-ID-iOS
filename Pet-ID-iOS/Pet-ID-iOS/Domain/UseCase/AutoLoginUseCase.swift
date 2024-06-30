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
    
    let userRepository: UserRepository
    
    func execute() -> AnyPublisher<Bool, Never> {
        return userRepository.getAuthorizationFromKeychain()
            .map { _ in true}
            .catch { _ in
                return Just(false)
            }
            .eraseToAnyPublisher()
    }
}
