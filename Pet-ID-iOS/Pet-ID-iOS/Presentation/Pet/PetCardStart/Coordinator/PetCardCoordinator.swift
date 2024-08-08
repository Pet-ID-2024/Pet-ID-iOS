import SwiftUI
import Combine
import UIKit

protocol PetCardCoordinatorFinishDelegate: AnyObject {
    func petCardStartCoordinatorDidFinish(_ coordinator: PetCardStartCoordinator)
}

final class PetCardStartCoordinator: Coordinator {
    var id: String = UUID().uuidString
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showPetCardStart()
        navigationBarHidden()
    }
    
    private func showPetCardStart() {
        let viewModel = PetCardStartViewModel()
        let petCardStartView = PetCardStart(viewModel: viewModel, coordinator: self)
        
        let petCardStartVC = UIHostingController(rootView: petCardStartView)
        push(petCardStartVC, animate: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: PetRegistrationState) {
        switch state {
        case .unregistered, .externalChip, .internalChip:
            navigateToUserInfo()
        case .back:
            navigateBack()
        }
    }
    
    func navigateToUserInfo() {
        let userInfoCoordinator = UserInfoCoordinator(navigationController: navigationController)
        childCoordinators[userInfoCoordinator.id] = userInfoCoordinator
        userInfoCoordinator.start()
    }
    
    func navigateBack() {
        pop(animated: true)
    }
    
//    func navigationBarHidden() {
//        navigationController.setNavigationBarHidden(hidden, animated: animated)
//    }
    
    deinit {
        Logger().debug("PetCardStartCoordinator Deinit \(self)")
    }
}
