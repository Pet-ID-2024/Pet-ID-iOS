//
//  AppleAuthProvider.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import AuthenticationServices
import CryptoKit

class AppleAuthProvider: NSObject {
    // 애플 로그인 중 발생할 수 있는 오류 타입 정의
    enum AppleAuthProviderError: Error {
        case failed
    }
    
    // 로그인 요청 시 사용될 nonce
    var currentNonce: String?
    let window: UIWindow?
    
    // 애플 로그인 후 결과를 처리할 콜백 함수
    var callBack: ((ASAuthorizationAppleIDCredential?, AppleAuthProviderError?) -> ())?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // 애플 로그인 후 결과를 처리할 콜백 함수
    func startAppleLogin(
        completion: @escaping (ASAuthorizationAppleIDCredential?, AppleAuthProviderError?) -> ()
    ) {
        self.callBack = completion
        
        // 랜덤 nonce 생성
        let nonce = randomNonceString()
        currentNonce = nonce
        
        // 애플 ID 인증 요청 생성
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        // 사용자 정보 (이름, 이메일) 요청
        request.requestedScopes = [.fullName, .email]
        
        // nonce를 SHA256으로 해시하여 추가
        request.nonce = sha256(nonce)
        
        // 인증 컨트롤러 설정 및 로그인 요청 실행
        let authorizationController = ASAuthorizationController(
            authorizationRequests: [request]
        )
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 문자열을 SHA256 해시값으로 변환
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    // 주어진 길이의 랜덤 nonce 문자열 생성
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        // 보안적으로 랜덤한 바이트 생성
        while remainingLength > 0 {
            var randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                
                return random
            }
            
            // 생성된 랜덤 값을 charset에서 추출해 문자열 생성
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthProvider: ASAuthorizationControllerDelegate {
    
    // 애플 로그인 성공 시 호출되는 콜백 메서드
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // 이전에 생성된 nonce와 비교해 인증 결과 처리
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            // 성공 시 콜백에 결과 전달
            self.callBack?(appleIdCredential, nil)
        }
        
        // 실패 시 콜백에 에러 전달
        self.callBack?(nil, .failed)
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleAuthProvider: ASAuthorizationControllerPresentationContextProviding {
    // 인증 화면을 표시할 창을 반환
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let window = self.window {
            return window
        } else {
            fatalError("Failed to show ASAuthorizationController")
        }
    }
}
