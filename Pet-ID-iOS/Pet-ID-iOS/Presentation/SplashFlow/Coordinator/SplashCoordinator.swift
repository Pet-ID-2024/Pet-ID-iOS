//
//  SplashCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import SwiftUI
import Combine

enum SplashCoordinatorResult {
    case login
    case tab
}

protocol SplashFinishDelegate: AnyObject {
    func finish(result: SplashCoordinatorResult)
}

final class SplashCoordinator: Coordinator {
    
    public let id: String = UUID().uuidString
    public var navigationController: UINavigationController
    public var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    weak var splashFinishDelegate: SplashFinishDelegate?
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    public init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    public func start() {
        showSplash()
    }
    
    func showSplash() {
        let viewModel = SplashViewModel()
        let splashVC = BaseHostingViewController(
            rootView: SplashView(viewModel: viewModel)
        )
        
        push(splashVC, animate: false, isRoot: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] result in
                
                guard let self else { return }
                
                switch result {
                case .login:
                    splashFinishDelegate?.finish(result: .login)
                    self.finish()
                case .main:
                    splashFinishDelegate?.finish(result: .tab)
                    self.finish()
                case .firstLogin:
                    showAccessibilityGuid()
                }
            })
            .store(in: &cancelBag)
    }
    
    func showAccessibilityGuid() {
        
        let viewModel = AccessibilityRightViewModel()
        let accessibilityVC = BaseHostingViewController(
            rootView: AccessibilityRightView(viewModel: viewModel)
        )
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] _ in
                guard let self else { return }
                
                splashFinishDelegate?.finish(result: .login)
                self.finish()
            })
            .store(in: &cancelBag)
        
        push(accessibilityVC, animate: false, isRoot: true)
    }
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}
