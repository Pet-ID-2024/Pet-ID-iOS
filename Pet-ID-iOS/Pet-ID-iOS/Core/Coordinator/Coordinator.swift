//
//  Coordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/23/24.
//

import Foundation
import UIKit

@MainActor
public protocol Coordinator: AnyObject, Identifiable {
    var id: String { get }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [String: any Coordinator] { get set }
    
    func start()
    func finish()
    func add(coordinator: any Coordinator)
    func free(coordinator: any Coordinator)
}

public extension Coordinator {
    
    func add(coordinator: any Coordinator) {
        childCoordinators[coordinator.id] = coordinator
    }
    
    func free(coordinator: any Coordinator) {
        childCoordinators[coordinator.id] = nil
    }
    
    func finish() {
        childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
        
        Logger().debug("remove after child coordinators : \(self)")
    }
    
    // MARK: - push, pop
    
    func push(_ viewController: UIViewController, animate: Bool = true, isRoot: Bool = false) {
        if isRoot {
            navigationController.viewControllers = [viewController]
        } else {
            navigationController.pushViewController(viewController, animated: animate)
        }
    }
    
    func pop(animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            navigationController.viewControllers = []
        } else {
            navigationController.popViewController(animated: animated)
        }
    }
    
    // MARK: - navigationBar

    func navigationBarHidden() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}



