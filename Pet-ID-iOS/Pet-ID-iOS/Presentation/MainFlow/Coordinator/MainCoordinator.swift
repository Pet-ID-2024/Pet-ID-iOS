//
//  MainCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Combine
import SwiftUI

enum MainCoordinatorResult {
    case main
}

final class MainCoordinator: BaseCoordinator<MainCoordinatorResult> {
    
    let coordinatorResult = PassthroughSubject<MainCoordinatorResult, Never>()
    
    override func start() -> AnyPublisher<MainCoordinatorResult, Never> {
        showMain()
        return coordinatorResult.eraseToAnyPublisher()
    }
    
    func showMain() {
        let mainVC = UIHostingController(
            rootView: MainView()
        )
        
        push(mainVC, animate: false, isRoot: true)
    }
}
