//
//  AppCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import SwiftUI
import Combine

public enum AppChildCoordinator: Hashable {
    case splash
    case login
    case main
}

public final class AppCoordinator: Coordinator {
    
    public let id: String = UUID().uuidString
    
    public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [String : any Coordinator]
    
    let window: UIWindow?
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        self.childCoordinators = [:]
        
        start()
    }
    
    public func start() {
        setup(with: window)
        runSplashFlow()
        bindLogout()
    }
    
    private func setup(with window: UIWindow?) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
    
    private func runSplashFlow() {
        let coordinator = SplashCoordinator(navigationController: navigationController)
        add(coordinator: coordinator)
        coordinator.finishDelegate = self
        coordinator.splashFinishDelegate = self
        coordinator.start()
    }
    
    private func runLoginFlow() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        add(coordinator: coordinator)
        coordinator.finishDelegate = self
        coordinator.loginFinishDelegate = self
        coordinator.start()
    }
    
    private func runMainFlow() {
        let coordinator = MainCoordinator(navigationController)
        
        add(coordinator: coordinator)
        coordinator.finishDelegate = self
        coordinator.start()
    }
    
    private func bindLogout() {
        PetIdNotificationCenter.shared.logout.subject
            .sink(receiveValue: { [weak self] _ in
                
                guard let self else { return }
                navigationController = UINavigationController()
                childCoordinators = [:]
                setup(with: self.window)
                runLoginFlow()
            })
            .store(in: &cancelBag)
    }
}

// MARK: - SplashFinishDelegate
extension AppCoordinator: SplashFinishDelegate {
    func finish(result: SplashCoordinatorResult) {
        switch result {
        case .login:
            runLoginFlow()
        case .main:
            runMainFlow()
        case .accessibilityGuid:
            break
        }
    }
}

// MARK: - LoginFinishDelegate
extension AppCoordinator: LoginFinishDelegate {
    func finish(result: LoginCoordinatorResult) {
        switch result {
        case .main:
            runMainFlow()
        }
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}

