//
//  SplashViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

enum SplashResult {
    case firstLogin
    case login
    case main
}

final class SplashViewModel: ViewModelable {

    private let autologinUseCase: AutoLoginUseCase
    
    var cancelBag: Set<AnyCancellable> = .init()
    
    var result: PassthroughSubject = PassthroughSubject<SplashResult, Never>()
    
    init(
        autologinUseCase: AutoLoginUseCase = DIContainer.shared.resolve(AutoLoginUseCase.self)
    ) {
        self.autologinUseCase = autologinUseCase
    }
    
    func run() {
        
        if UserDefaultManager.shared.isFirstExecute {
            result.send(.firstLogin)
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
