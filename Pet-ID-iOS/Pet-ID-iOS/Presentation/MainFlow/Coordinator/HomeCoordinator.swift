//
//  MainCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Combine
import SwiftUI

final class HomeCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let viewModel = HomeViewModel()
        let homeVC = BaseHostingViewController(rootView: HomeView(viewModel: viewModel, coordinator: self))
        push(homeVC, animate: false, isRoot: true)
    }
    
    func showPetCardView() {
            let petCardView = PetCardView()
            let petCardVC = UIHostingController(rootView: petCardView)
            navigationController.pushViewController(petCardVC, animated: true)
        }
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}

extension HomeCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
