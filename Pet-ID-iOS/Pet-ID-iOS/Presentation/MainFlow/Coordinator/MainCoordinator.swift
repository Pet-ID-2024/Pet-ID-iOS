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
    case finish
}

final class MainCoordinator: Coordinator {
    
    var id: String = UUID().uuidString
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMain()
    }
    
    func showMain() {
        let mainVC = UIHostingController(
            rootView: MainView()
        )
        
        push(mainVC, animate: false, isRoot: true)
    }
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}
