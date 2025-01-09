////
////  LoginCoordinator.swift
////  Pet-ID-iOS
////
////  Created by 강현준 on 7/8/24.
////
//
//import Combine
//import SwiftUI
//
//enum LoginCoordinatorResult {
//    case tab
//}
//
//protocol LoginFinishDelegate: AnyObject {
//    func finish(result: LoginCoordinatorResult)
//}
//
//final class LoginCoordinator: Coordinator {
//
//    var id: String = UUID().uuidString
//    var navigationController: UINavigationController
//    var childCoordinators: [String : any Coordinator] = [:]
//    private var cancelBag = Set<AnyCancellable>()
//
//    weak var finishDelegate: CoordinatorFinishDelegate?
//    weak var loginFinishDelegate: LoginFinishDelegate?
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        showLoginMain()
//        navigationBarHidded()
//    }
//
//    func showLoginMain() {
//        let viewModel = LoginMainViewModel()
//        let loginMainVC = BaseHostingViewController(
//            rootView: LoginMainView(
//                viewModel: viewModel
//            )
//        )
//
//        viewModel.result.subject
//            .sink(receiveValue: { [weak self] in
//                switch $0 {
//                case .main:
//                    print("🟢 Login successful, finishing LoginCoordinator and navigating to tab.")
//                    self?.loginFinishDelegate?.finish(result: .tab)
//                    self?.finish()
//                case .signUp(let oauth):
//                    print("🟡 Navigating to Terms Agreement for sign up.")
//                    self?.pushTermsAgreement(oauth: oauth)
//                }
//            }).store(in: &cancelBag)
//
//        push(loginMainVC, animate: false, isRoot: true)
//    }
//
//    func pushTermsAgreement(oauth: OAuth) {
//        let viewModel = TermsAgreementViewModel(oauth: oauth)
//        let termsAgreementVC = BaseHostingViewController(
//            rootView: TermsAgreementView(
//                viewModel: viewModel
//            )
//        )
//
//        viewModel.result.subject
//            .sink(receiveValue: { [weak self] in
//                switch $0 {
//                case .back:
//                    self?.pop(animated: true)
//                case .signup:
//                    self?.loginFinishDelegate?.finish(result: .tab)
//                    self?.finish()
//                }
//            }).store(in: &cancelBag)
//
//        push(termsAgreementVC)
//    }
//
//    deinit {
//        Logger().debug("Coordinator Deinit \(self)")
//    }
//}


import Combine
import SwiftUI

enum LoginCoordinatorResult {
    case tab
}

protocol LoginFinishDelegate: AnyObject {
    func finish(result: LoginCoordinatorResult)
}

final class LoginCoordinator: Coordinator {

    var id: String = UUID().uuidString
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
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

    // 로그인 메인 화면 표시
    func showLoginMain() {
        let viewModel = LoginMainViewModel()
        let loginMainVC = BaseHostingViewController(
            rootView: LoginMainView(viewModel: viewModel)
        )

        viewModel.result.subject
            .sink(receiveValue: { [weak self] result in
                guard let self else { return }
                switch result {
                case .main: // 메인 화면으로 이동
                    Logger().info("Login completed. Redirecting to Main Tab.")
                    self.finishToMain()
                case .terms(let oauth): // 약관 동의 화면으로 이동
                    Logger().info("Redirecting to Terms Agreement View.")
                    self.showTermsAgreement(oauth: oauth)
                }
            }).store(in: &cancelBag)

        push(loginMainVC, animate: false, isRoot: true)
    }

    // 약관 동의 화면 표시
    func showTermsAgreement(oauth: OAuth) {
        Logger().debug("Navigating to Terms Agreement View")
        let viewModel = TermsAgreementViewModel(oauth: oauth)
        let termsAgreementVC = BaseHostingViewController(
            rootView: TermsAgreementView(viewModel: viewModel)
        )

        viewModel.result.subject
            .sink(receiveValue: { [weak self] result in
                guard let self else { return }
                switch result {
                case .login: // 약관 동의 완료 후 메인 화면 이동
                    Logger().info("Terms Agreement completed. Redirecting to Main Tab.")
                    self.finishToMain()
                }
            }).store(in: &cancelBag)

        push(termsAgreementVC, animate: true)
    }

    // 메인 화면 이동
    func finishToMain() {
        Logger().debug("Finishing Login Flow. Redirecting to Main Tab.")
        self.loginFinishDelegate?.finish(result: .tab)
        self.finish()
    }

    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}
