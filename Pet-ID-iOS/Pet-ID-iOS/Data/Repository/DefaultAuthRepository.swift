//
//  AuthRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Combine

struct DefaultAuthRepository: AuthRepository {
    
    private let dataSource: AuthDataSource
    private let keychainManager: KeychainManagerProtocol
    
    init(
        dataSource: AuthDataSource = DefaultAuthDataSource(),
        keychainManager: KeychainManagerProtocol = KeychainManager()
    ) {
        self.dataSource = dataSource
        self.keychainManager = keychainManager
    }
    
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
    
    func storeAuthorizationToKeychain(auth: Authorization) -> Bool {
        do {
            let data = try JSONEncoder().encode(auth)
            return keychainManager.save(key: .authorization, data: data)
        } catch {
            return false
        }
    }
    
    func login(oauth: OAuth, fcmToken: String) async -> Result<Authorization, NetworkError> {
        let request = LoginRequestDTO(
            sub: oauth.token,
            fcmToken: fcmToken
        )
        
        return await dataSource.login(req: request)
            .map { $0.toDomain() }
    }
}
