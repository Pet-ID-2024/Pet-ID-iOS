//
//  LoginCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Combine
import SwiftUI

enum LoginCoordinatorResult {
    case main
}

final class LoginCoordinator: BaseCoordinator<LoginCoordinatorResult> {
    
    let coordinatorResult = PassthroughSubject<LoginCoordinatorResult, Never>()
    
    override func start() -> AnyPublisher<LoginCoordinatorResult, Never> {
        showLoginMain()
        navigationBarHidded()
        return coordinatorResult.eraseToAnyPublisher()
    }
    
    func showLoginMain() {
        let viewModel = LoginMainViewModel()
        let loginMainVC = UIHostingController(
            rootView: LoginMainView(
                viewModel: viewModel
            )
        )
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] in
                switch $0 {
                case .main:
                    self?.coordinatorResult.send(.main)
                case .signUp(let oauth):
                    self?.pushTermsAgreement(oauth: oauth)
                }
            }).store(in: &cancelBag)
        
        push(loginMainVC, animate: false, isRoot: true)
    }
    
    func pushTermsAgreement(oauth: OAuth) {
        let viewModel = TermsAgreementViewModel(oauth: oauth)
        let termsAgreementVC = UIHostingController(
            rootView: TermsAgreementView(
                viewModel: viewModel
            )
        )
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] in
                switch $0 {
                case .back:
                    self?.pop(animated: true)
                case .signup:
                    self?.coordinatorResult.send(.main)
                }
            }).store(in: &cancelBag)
        
        push(termsAgreementVC)
    }
}
