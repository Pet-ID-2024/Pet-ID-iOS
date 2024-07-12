//
//  LoginCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Combine
import SwiftUI

enum LoginCoordinatorResult {
    
}

final class LoginCoordinator: BaseCoordinator<LoginCoordinatorResult> {
    
    let coordinatorResult = PassthroughSubject<LoginCoordinatorResult, Never>()
    
    override func start() -> AnyPublisher<LoginCoordinatorResult, Never> {
        showLoginMain()
        return coordinatorResult.eraseToAnyPublisher()
    }
    
    func showLoginMain() {
        let viewModel = LoginMainViewModel()
        let loginMainVC = UIHostingController(
            rootView: LoginMainView(
                viewModel: viewModel
            )
        )
        
        viewModel.result
            .sink(receiveValue: { [weak self] in
                switch $0 {
                case .main: break
                case .signUp:
                    self?.pushTermsAgreement()
                }
            }).store(in: &cancelBag)
        
        push(loginMainVC, animate: false, isRoot: true)
    }
    
    func pushTermsAgreement() {
        let termsAgreementVC = UIHostingController(
            rootView: TermsAgreementView()
        )
        
        push(termsAgreementVC)
    }
}
