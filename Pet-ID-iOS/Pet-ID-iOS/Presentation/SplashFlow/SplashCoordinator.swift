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
    case accessibilityGuid
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
        let splashVC = UIHostingController(
            rootView: SplashView(viewModel: viewModel)
        )
        
        push(splashVC, animate: false, isRoot: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] result in
                
                guard let self else { return }
                
                switch result {
                case .login:
                    splashFinishDelegate?.finish(result: .login)
                case .main:
                    splashFinishDelegate?.finish(result: .main)
                case .firstLogin:
                    splashFinishDelegate?.finish(result: .accessibilityGuid)
                }
                
                self.finish()
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
