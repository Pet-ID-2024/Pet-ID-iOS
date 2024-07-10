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
        let loginMainVC = UIHostingController(rootView: LoginMainView())
        
        push(loginMainVC, animate: false, isRoot: true)
    }
}
