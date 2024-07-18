//
//  SplashViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

enum SplashViewResult {
    case firstLogin
    case login
    case main
}

final class SplashViewModel: BaseViewModel<SplashViewResult> {

    private let autologinUseCase: AutoLoginUseCase

    init(
        autologinUseCase: AutoLoginUseCase = DefaultAutoLoginUseCase()
    ) {
        self.autologinUseCase = autologinUseCase
    }
    
    @MainActor func run() {
        
        if UserDefaultManager.shared.isFirstExecute {
            self.result.send(.firstLogin)
        } else {
            autologinUseCase.execute()
                .sink { [weak self] result in
                    if result {
                        self?.result.send(.main)
                    } else {
                        self?.result.send(.login)
                    }
                }
                .store(in: &cancelBag)
        }

    }
}
