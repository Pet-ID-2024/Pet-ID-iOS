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
    case main
}

final class SplashCoordinator: BaseCoordinator<SplashCoordinatorResult> {
    
    let coordinatorResult = PassthroughSubject<SplashCoordinatorResult, Never>()
    
    override func start() -> AnyPublisher<SplashCoordinatorResult, Never> {
        showSplash()
        return coordinatorResult.eraseToAnyPublisher()
    }
    
    func showSplash() {
        let viewModel = SplashViewModel()
        let splashVC = UIHostingController(
            rootView: SplashView(viewModel: viewModel)
        )
        
        push(splashVC, animate: false, isRoot: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .login:
                    self?.coordinatorResult.send(.login)
                case .main:
                    self?.coordinatorResult.send(.main)
                case .firstLogin:
                    self?.showAccessibilityGuid()
                }
            })
            .store(in: &cancelBag)
    }
    
    func showAccessibilityGuid() {
        let accessibilityVC = UIHostingController(
            rootView: AccessibilityGuideView()
        )
        
        push(accessibilityVC, animate: false, isRoot: true)
    }
}
