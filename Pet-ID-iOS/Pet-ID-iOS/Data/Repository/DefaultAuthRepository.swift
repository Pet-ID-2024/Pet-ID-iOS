//
//  AuthRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Combine

// 인증 관련 데이터를 처리하는 기본 구조체
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
    
    // 키체인에서 인증 정보를 가져옴 비동기 방식.
    func fetchAuthTokensFromKeychain() -> AnyPublisher<Authorization, UserError> {
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
    
    // 키체인에서 인증 정보를 가져옴 동기 방식.
    func fetchAuthTokensFromKeychainSync() throws -> Authorization {
        guard let data = keychainManager.load(key: .authorization),
              let authorization = try? JSONDecoder().decode(AuthorizationDTO.self, from: data) else {
            throw UserError.userDataNotFound
        }
        
        return authorization.toDomain()
    }
    
    // 인증 정보를 키체인에 저장
    func storeAuthorizationToKeychain(auth: Authorization) -> Bool {
        do {
            let data = try JSONEncoder().encode(auth)
            return keychainManager.save(key: .authorization, data: data)
        } catch {
            return false
        }
    }
    
    // 키체인에 저장된 인증 정보를 업데이트
    func updateAuthorizationToKeychain(auth: Authorization) -> Bool {
        do {
            let data = try JSONEncoder().encode(auth)
            return keychainManager.update(key: .authorization, data: data)
        } catch {
            return false
        }
    }
    
    // 키체인에서 인증정보를 삭제
    func deleteAuthorizationFromKeychain() -> Bool {
        return keychainManager.delete(key: .authorization)
    }
    
    // 사용자를 로그인함 비동기 방식
    func login(oauth: OAuth, fcmToken: String) async throws -> Authorization {
        let request = LoginRequestDTO(
            sub: oauth.id,
            fcmToken: fcmToken,
            idToken: oauth.type == .google ? oauth.accessToken : nil
        )
        
        let response = try await dataSource.login(req: request)
            
        return response.toDomain()
    }
    
    // 사용자를 가입시킴 비동기 방식.
    func join(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws -> Authorization {
        let request = JoinRequestDTO(
            token: oauth.accessToken,
            fcmToken: fcmToken,
            ad: agreedAd
        )
        let response = try await dataSource.join(req: request, platform: oauth.type.toServerString)
        
        return response.toDomain()
    }
    
    // 리프레시 토큰을 사용해 새로운 인증 정보를 가져옴 비동기 방식.
    func refresh(refreshToken: String) async throws -> Authorization {
        let request = TokenRefreshRequestDTO(
            refreshToken: refreshToken
        )
        
        let response = try await dataSource.refresh(req: request)
        
        return response.toDomain()
    }
}
