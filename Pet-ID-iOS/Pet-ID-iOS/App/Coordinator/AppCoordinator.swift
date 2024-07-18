//
//  AppCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import SwiftUI
import Combine

public final class AppCoordinator: BaseCoordinator<Void> {
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        
        super.init(UINavigationController())
    }
    
    @discardableResult
    public override func start() -> AnyPublisher<Void, Never> {
        setup(with: window)
        runSplashFlow()
        
        return Empty().eraseToAnyPublisher()
    }
    
    private func setup(with window: UIWindow?) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
    
    private func runSplashFlow() {
        let coordinator = SplashCoordinator(navigationController)
        
        coordinate(to: coordinator)
            .sink(receiveValue: { [weak self] result in
                
                switch result {
                case .login:
                    self?.runLoginFlow()
                case .main:
                    self?.runMainFlow()
                }
                
            }).store(in: &cancelBag)
    }
    
    private func runLoginFlow() {
        let coordinator = LoginCoordinator(navigationController)
        
        coordinate(to: coordinator)
            .sink(receiveValue: { [weak self] in
                switch $0 {
                case .main:
                    self?.runMainFlow()
                }
            }).store(in: &cancelBag)
    }
    
    private func runMainFlow() {
        let coordinator = MainCoordinator(navigationController)
        
        coordinate(to: coordinator)
            .sink(receiveValue: { _ in })
            .store(in: &cancelBag)
    }
}
