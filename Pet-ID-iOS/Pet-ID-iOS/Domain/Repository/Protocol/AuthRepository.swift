//
//  AuthRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Combine

protocol AuthRepository {
    
    /// 키체인으로부터 인증정보를 가져옵니다.
    /// - Returns: Accesstoken, RefreshToken
    func getAuthorizationFromKeychain() -> AnyPublisher<Authorization, UserError>
    
    
    /// 키체인으로부터 인증정보를 가져옵니다.
    /// - Returns: Accesstoken, RefreshToken
    func getAuthorizationFromKeychain() throws -> Authorization
    
    /// 키체인에 인증정보를 저장합니다
    /// - Parameter auth: 저장할 Authorization
    /// - Returns: true: 저장 성공, false: 저장 실패
    func storeAuthorizationToKeychain(auth: Authorization) -> Bool
    
    /// 키체인에 인증을 업데이트합니다
    func updateAuthorizationToKeychain(auth: Authorization) -> Bool
    
    
    /// 인증정보를 삭제합니다
    /// - Returns: 성공 / 실패 여부
    func deleteAuthorizationFromKeychain() -> Bool
    
    /// Login을 요청합니다.
    /// - Parameters:
    ///   - oauth: OAuth
    ///   - fcmToken: fcmToken
    /// - Returns: 로그인의 결과를 리턴
    func login(oauth: OAuth, fcmToken: String) async throws -> Authorization 
    
    
    /// 회원가입을 요청합니다.
    /// - Parameter oauth:
    /// - Returns: Authorization
    func join(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws -> Authorization
    
    /// Token을 refresh합니다.
    /// - Parameter refreshToken: refreshToken
    func refresh(refreshToken: String) async throws -> Authorization
}
