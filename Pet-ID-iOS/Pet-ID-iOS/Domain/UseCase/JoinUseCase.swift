//
//  JoinUseCase.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

protocol JoinUseCase {
    func execute(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws
}

struct DefaultJoinUseCase: JoinUseCase {
    
    let authRepository: AuthRepository
    
    init(
        authRepository: AuthRepository = DefaultAuthRepository()
    ) {
        self.authRepository = authRepository
    }
    
    func execute(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws {
        let authorization = try await authRepository.join(oauth: oauth, fcmToken: fcmToken, agreedAd: agreedAd)
    }
}
