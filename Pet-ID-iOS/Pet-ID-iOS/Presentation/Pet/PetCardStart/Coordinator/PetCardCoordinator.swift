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
        print("Starting PetCardStartCoordinator")
        showPetCardStart()
        navigationBarHidden()
    }
    
    private func showPetCardStart() {
        print("Showing PetCardStart view")
        let viewModel = PetCardStartViewModel()
        let petCardStartView = PetCardStart(viewModel: viewModel, coordinator: self)
        
        let petCardStartVC = UIHostingController(rootView: petCardStartView)
        push(petCardStartVC, animate: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                print("PetRegistrationState received in Coordinator: \(state)")
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: PetRegistrationState) {
        print("Handling state selection: \(state)")
        switch state {
        case .unregistered, .externalChip, .internalChip:
            print("State matched: \(state). Navigating to UserInfo.")
            navigateToUserInfo()
        case .back:
            navigateBack()
        }
    }
    
    func navigateToUserInfo() {
        print("Navigating to UserInfo")
        let userInfoCoordinator = UserInfoCoordinator(navigationController: navigationController)
        childCoordinators[userInfoCoordinator.id] = userInfoCoordinator
        userInfoCoordinator.start()
    }
    
    func navigateBack() {
        print("Navigating back")
        pop(animated: true)
    }
    
    deinit {
        Logger().debug("PetCardStartCoordinator Deinit \(self)")
    }
}
