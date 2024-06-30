//
//  UserRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

struct DefaultUserRepository: UserRepository {
    
    private let keychainManager: KeychainManagerProtocol
    
    func getAuthorizationFromKeychain() -> AnyPublisher<Authorization, UserError> {
        guard let data = keychainManager.load(key: .authorization),
              let authorization = try? JSONDecoder().decode(AuthorizationDTO.self, from: data) else {
            return Fail(error: UserError.userDataNotFound).eraseToAnyPublisher()
        }
        
        return Just(
            authorization.toDomain()
        )
        .setFailureType(to: UserError.self)
        .eraseToAnyPublisher()
    }
    
    init(keychainManager: KeychainManagerProtocol) {
        self.keychainManager = keychainManager
    }
}
