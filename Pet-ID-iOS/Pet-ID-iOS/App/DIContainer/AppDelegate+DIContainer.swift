//
//  DIContainer.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

extension AppDelegate {
    
    var container: DIContainer {
        DIContainer.shared
    }
    
    func registerDependencies() {
        registerDataSources()
        registerRepositories()
        registerUseCases()
    }
    
    func registerDataSources() {
        container.register(interface: KeychainProtocol.self, implement: { _ in Keychain() })
        
        container.register(interface: KeychainManagerProtocol.self,
                           implement: {
            resolver in
            return KeychainManager(
                keychain: resolver.resolve(
                    KeychainProtocol.self
                )
            )
        })
    }
    
    func registerRepositories() {
        
        container.register(interface: UserRepository.self, implement: { resolver in
            return DefaultUserRepository(
                keychainManager: resolver.resolve(KeychainManagerProtocol.self)!
            )
        })
    }
    
    func registerUseCases() {
        container.register(interface: AutoLoginUseCase.self, implement: { res in
            return DefaultAutoLoginUseCase(
                userRepository: res.resolve(UserRepository.self)!
            )
        })
    }
}
