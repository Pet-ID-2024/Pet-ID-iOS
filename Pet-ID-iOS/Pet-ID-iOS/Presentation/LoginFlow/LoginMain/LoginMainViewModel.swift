//
//  LoginMainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Foundation
import AuthenticationServices
import Combine

enum LoginMainReesult {
    case main
    case signUp
}

final class LoginMainViewModel: BaseViewModel {
    private let loginUseCase: LoginUseCase
    
    var result: PassthroughSubject = PassthroughSubject<LoginMainReesult, Never>()
    
    init(loginUseCase: LoginUseCase = DefaultLoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
}

// MARK: - AppleLogin
extension LoginMainViewModel {
    func runAppleLogin(credential: ASAuthorizationAppleIDCredential) {
        logger.debug("Success to get Apple auth credential")
        
        guard let tokenData = credential.identityToken else {
            logger.error("AppleCredentialError: identiyToken is nil")
            return
        }
        
        guard let tokenString = String(data: tokenData, encoding: .utf8) else {
            logger.error("AppleCredentialError: data to string")
            return
        }
        
        requestOAuthLogin(
            oauth: OAuth(
                type: .apple,
                token: tokenString
            )
        )
    }
}

// MARK: - CallLoginUseCase
extension LoginMainViewModel {
    
    func requestOAuthLogin(
        oauth: OAuth,
        fcmToken: String = UserDefaultManager.shared.fcmToken
    ) {
        Task {
            let result = await loginUseCase.execute(oauth: oauth, fcmToken: fcmToken)
            
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case .statusCode(let code):
                    if code == 404 {
                        await toSignUp()
                    }
                    
                default:
                    break
                }
            }
        }
    }
    
    @MainActor func toSignUp() {
        self.result.send(.signUp)
    }
}
