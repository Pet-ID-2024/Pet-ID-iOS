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

protocol LoginFinishDelegate: AnyObject {
    func finish(result: LoginCoordinatorResult)
}

final class LoginCoordinator: Coordinator {
    
    var id: String = UUID().uuidString
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    weak var loginFinishDelegate: LoginFinishDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginMain()
        navigationBarHidded()
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
                    self?.loginFinishDelegate?.finish(result: .main)
                case .signUp(let oauth):
                    self?.pushTermsAgreement(oauth: oauth)
                }
                
                self?.finish()
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
                    break
                }
            }).store(in: &cancelBag)
        
        push(termsAgreementVC)
    }
}
