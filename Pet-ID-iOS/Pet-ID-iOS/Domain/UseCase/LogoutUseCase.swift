//
//  LogoutUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation

/// 로그아웃 사용 사례를 위한 프로토콜
protocol LogoutUseCase {
    /// 로그아웃 실행 메서드
    func execute()
}

/// 기본 구현체로, 사용자의 로그아웃을 처리합니다.
struct DefaultLogoutUseCase: LogoutUseCase {
    
    let authRepository: AuthRepository // 인증 관련 저장소
    
    init(
        authRepository: AuthRepository = DefaultAuthRepository()
    ) {
        self.authRepository = authRepository // 기본 인증 저장소를 주입합니다.
    }
    
    /// 로그아웃 실행
    func execute() {
        // 키체인에서 인증 정보를 삭제합니다.
        let result = authRepository.deleteAuthorizationFromKeychain()
        
        // 삭제가 성공하면 로그아웃 알림을 보냅니다.
        if result {
            PetIdNotificationCenter.shared.logout.send(())
        }
    }
}
