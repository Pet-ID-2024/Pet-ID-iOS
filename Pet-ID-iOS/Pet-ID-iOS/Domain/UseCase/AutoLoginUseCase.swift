//
//  AutoLoginUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

// 자동 로그인을 위한 사용사례 프로토콜
protocol AutoLoginUseCase {
    func execute() -> AnyPublisher<Bool, Never> // 자동 로그인 실행 메서드
}

// 자동 로그인 사용 사례 처리
struct DefaultAutoLoginUseCase: AutoLoginUseCase {
    
    let authRepository: AuthRepository // 인증 관려 저장소
    
    init(authRepository: AuthRepository = DefaultAuthRepository()) {
        self.authRepository = authRepository // 기본 인증 저장소를 주입
    }
    
    // 자동 로그인 실행
    // returns: 로그인 성공 여부를 포함한 Publisher
//    func execute() -> AnyPublisher<Bool, Never> {
//        return authRepository.fetchAuthTokensFromKeychain() // 키체인에서 인증 정보 가져오기
//            .map { _ in true} // 인증 정보가 존재하면 true 반환
//            .catch { _ in
//                return Just(false) // 오류 발생 시 false 반환
//            }
//            .eraseToAnyPublisher() // 결과를 AnyPublisher로 변환
//    }
    func execute() -> AnyPublisher<Bool, Never> {
        do {
            let authorization: Authorization = try authRepository.fetchAuthTokensFromKeychainSync()
            print("Access token: \(authorization.accessToken)") // 추가
            return Just(true).eraseToAnyPublisher()
        } catch {
            print("Error fetching access token: \(error)")
            return Just(false).eraseToAnyPublisher()
        }
    }
}
