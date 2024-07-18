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
    
    func getAuthorizationFromKeychain() throws -> Authorization {
        guard let data = keychainManager.load(key: .authorization),
              let authorization = try? JSONDecoder().decode(AuthorizationDTO.self, from: data) else {
            throw UserError.userDataNotFound
        }
        
        return authorization.toDomain()
    }
    
    func storeAuthorizationToKeychain(auth: Authorization) -> Bool {
        do {
            let data = try JSONEncoder().encode(auth)
            return keychainManager.save(key: .authorization, data: data)
        } catch {
            return false
        }
    }
    
    func updateAuthorizationToKeychain(auth: Authorization) -> Bool {
        do {
            let data = try JSONEncoder().encode(auth)
            return keychainManager.update(key: .authorization, data: data)
        } catch {
            return false
        }
    }
    
    func login(oauth: OAuth, fcmToken: String) async throws -> Authorization {
        let request = LoginRequestDTO(
            sub: oauth.id,
            fcmToken: fcmToken
        )
        
        let response = try await dataSource.login(req: request)
            
        return response.toDomain()
    }
    
    func join(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws -> Authorization {
        let request = JoinRequestDTO(
            token: oauth.accessToken,
            fcmToken: fcmToken,
            ad: agreedAd
        )
        let response = try await dataSource.join(req: request, platform: oauth.type.toServerString)
        
        return response.toDomain()
    }
    
    func refresh(refreshToken: String) async throws -> Authorization {
        let request = TokenRefreshRequestDTO(
            refreshToken: refreshToken
        )
        
        let response = try await dataSource.refresh(req: request)
        
        return response.toDomain()
    }
}
