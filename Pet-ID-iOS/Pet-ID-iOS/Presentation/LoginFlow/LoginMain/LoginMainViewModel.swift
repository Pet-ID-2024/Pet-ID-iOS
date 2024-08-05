//
//  LoginMainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Foundation
import AuthenticationServices
import KakaoSDKUser
import NaverThirdPartyLogin
import Combine
import Alamofire
import GoogleSignIn

enum LoginMainReesult {
    case main
    case signUp(OAuth)
}

final class LoginMainViewModel: BaseViewModel<LoginMainReesult> {
    private let loginUseCase: LoginUseCase
    private let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    init(loginUseCase: LoginUseCase = DefaultLoginUseCase()) {
        self.loginUseCase = loginUseCase
        
        super.init()
        
    }
    
    @MainActor func toSignUp(oauth: OAuth) {
        self.result.send(.signUp(oauth))
    }
}

// MARK: - GoogleLogin
extension LoginMainViewModel {
    func runGoogleLogin() {
        
        guard let vc = UIWindow.currentKeyWindow?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] result, error in
            
            guard let self else { return }
            
            if let error = error {
                logger.error(error)
                return
            }
            
            guard let user = result?.user,
            let id = user.userID else { return }
            
            let accessToken = user.accessToken.tokenString
            
            let oauth = OAuth(type: .google, accessToken: accessToken, id: id)
            
            requestOAuthLogin(oauth: oauth)
        }
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

// MARK: - NaverLogin
extension LoginMainViewModel: NaverThirdPartyLoginConnectionDelegate, UIApplicationDelegate{
    
    private func setNaverLoginInstance() {
        naverLoginInstance?.delegate = self
        naverLoginInstance?.resetToken()
        
    }
    
    func runNaverLogin() {
        
        setNaverLoginInstance()
        
        naverLoginInstance?.requestThirdPartyLogin()
    }
    
    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        logger.debug("\nSuccess Naver Login")
        
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        
        if !isValidAccessToken { return }
        
        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        guard let refreshToken = naverLoginInstance?.refreshToken else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { [weak self] response in
            
            guard let self else { return }
            
            guard let result = response.value as? [String: Any],
            let object = result["response"] as? [String: Any] else { return }
            
            guard let id = object["id"] as? String,
                  let accessToken = naverLoginInstance?.accessToken else { return }
            
            let info = "ID: \(id)"
            
            logger.debug("\n Naver Login Response \n\(info)")
            
            let oauth = OAuth(type: .naver, accessToken: accessToken, id: id)
            
            requestOAuthLogin(oauth: oauth)
        }
        
    }
    
    // referesh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        logger.debug("log out")
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        logger.error("error = \(error.localizedDescription)")
        self.naverLoginInstance?.requestDeleteToken()
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
                    return
                }
                
                guard let accessToken = token?.accessToken else { return }
                
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
            UserApi.shared.loginWithKakaoAccount{ [weak self] token, error in
                
                guard let self else { return }
                
                if let error = error {
                    self.logger.error(error)
                    return
                }
                
                guard let accessToken = token?.accessToken else { return }
                
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
                if result {
                    await self.result.send(.main)
                } else {
                    logger.error("Leaguend Error")
                }
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
