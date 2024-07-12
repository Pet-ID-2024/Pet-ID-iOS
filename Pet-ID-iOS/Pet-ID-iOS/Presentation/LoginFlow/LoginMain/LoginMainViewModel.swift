//
//  LoginMainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Foundation
import AuthenticationServices

final class LoginMainViewModel: BaseViewModel {
    
}

// MARK: - AppLogin
extension LoginMainViewModel {
    func runAppleLogin(credential: ASAuthorizationAppleIDCredential) {
        logger.debug("Success to get Apple auth credential")
    }
}

