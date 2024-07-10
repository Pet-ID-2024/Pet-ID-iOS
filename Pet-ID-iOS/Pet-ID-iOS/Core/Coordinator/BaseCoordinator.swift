//
//  BaseCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import UIKit
import Combine

open class BaseCoordinator<ResultType> {
    
    public typealias CoordinateResult = ResultType

    public let identifier: String = UUID().uuidString
    public var childCoordinators: [String: Any] = [:]
    public var navigationController: UINavigationController
    public var cancelBag = Set<AnyCancellable>()
    
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    open func start() -> AnyPublisher<ResultType, Never> {
        fatalError("Start method should be implemented!!")
    }
    
    open func finish() {
        
    }
    
    public func coordinate<T>(to coordinator: BaseCoordinator<T>) -> AnyPublisher<T, Never> {
        append(coordinator: coordinator)
        return coordinator.start()
            .handleEvents(
                receiveCompletion: { [weak self] _ in
                    self?.remove(coordinator: coordinator)
                }
            )
            .eraseToAnyPublisher()
    }
    
    private func append<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func remove<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    public func push(_ viewController: UIViewController, animate: Bool = true, isRoot: Bool = false) {
        if isRoot {
            navigationController.viewControllers = [viewController]
        } else {
            navigationController.pushViewController(viewController, animated: animate)
        }
    }
    
    public func pop(animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            navigationController.viewControllers = []
        } else {
            navigationController.popViewController(animated: animated)
        }
    }
}