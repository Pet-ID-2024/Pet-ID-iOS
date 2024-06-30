//
//  SplashViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

final class SplashViewModel: BaseViewModel {
    
    private let autologinUseCase: AutoLoginUseCase
    
    let autoLoginPublisher = PassthroughSubject<Bool, Never>()
    
    override init() {
        self.autologinUseCase = DIContainer.shared.resolve(AutoLoginUseCase.self)
    }
    
    func autoLogin() {
        autologinUseCase.execute()
            .sink { [weak self] result in
                self?.autoLoginPublisher.send(result)
            }
            .store(in: &cancellBag)
    }
}
