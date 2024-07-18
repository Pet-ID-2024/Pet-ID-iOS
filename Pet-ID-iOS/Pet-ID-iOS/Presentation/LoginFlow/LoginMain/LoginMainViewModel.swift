//
//  LoginMainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Foundation
import AuthenticationServices
import KakaoSDKUser
import Combine

enum LoginMainReesult {
    case main
    case signUp(OAuth)
}

final class LoginMainViewModel: BaseViewModel, ViewModelResultProvidable {
    private let loginUseCase: LoginUseCase
    
    var result: PassthroughSubject = PassthroughSubject<LoginMainReesult, Never>()
    
    init(loginUseCase: LoginUseCase = DefaultLoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    @MainActor func toSignUp(oauth: OAuth) {
        self.result.send(.signUp(oauth))
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
                accessToken: "",
                id: tokenString
            )
        )
    }
}

// MARK: - KakaoLogin
extension LoginMainViewModel {
    
    func runKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (token, error) in
                
                guard let self else { return }
                
                if let error = error {
                    self.logger.error(error)
                }
                
                guard let accessToken = token?.accessToken else { return }
                
                guard let idToken = token?.idToken else { return }
                
                UserApi.shared.me(completion: { user, error in
                    
                    guard let user else { return }
                    
                    guard let id = user.id else { return }
                    
                    let oauth: OAuth = OAuth(
                        type: .kakao,
                        accessToken: accessToken,
                        id: "\(id)"
                    )
                    
                    self.requestOAuthLogin(
                        oauth: oauth
                    )
                })
                
            }
        } else {
            
        }
    }
    
    
    
}

// MARK: - CallLoginUseCase
extension LoginMainViewModel {
    
    func requestOAuthLogin(
        oauth: OAuth,
        fcmToken: String = UserDefaultManager.shared.fcmToken
    ) {
        Task {
            do {
                let result = try await loginUseCase.execute(oauth: oauth, fcmToken: fcmToken)
            } catch let error as NetworkError {
                if case .invalidResponse(let errorModel) = error {
                    if errorModel.code == 404 {
                        await toSignUp(oauth: oauth)
                    }
                } else {
                    logger.error(error)
                }
            }
            
        }
    }
}
