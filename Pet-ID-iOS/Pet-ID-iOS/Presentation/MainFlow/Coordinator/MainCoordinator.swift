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

final class MainCoordinator: Coordinator, ObservableObject {
    
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
        let viewModel = MainViewModel(coordinator: self)
        let mainVC = UIHostingController(
            rootView: MainView(viewModel: viewModel, coordinator: self)
        )
        
        push(mainVC, animate: false, isRoot: true)
    }
    
    func showBanner() {
        let bannerVC = UIHostingController(rootView: Banner())
        navigationController.pushViewController(bannerVC, animated: true)
    }
    
    func showPetCard() {
        let petCardVC = UIHostingController(rootView: PetCardView())
        navigationController.pushViewController(petCardVC, animated: true)
    }
    
    func showPetCardStart() {
            let petCardStartCoordinator = PetCardStartCoordinator(navigationController: navigationController)
            childCoordinators[petCardStartCoordinator.id] = petCardStartCoordinator
            petCardStartCoordinator.start()
        }
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}
