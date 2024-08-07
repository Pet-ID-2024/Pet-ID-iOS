import SwiftUI
import Combine
import UIKit

final class UserInfoCoordinator: Coordinator {
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("Starting UserInfoCoordinator")
        showUserInfo()
        navigationBarHidden()
    }
    
    private func showUserInfo() {
        print("Showing UserInfo view")
        let viewModel = UserInfoViewModel()
        let userInfoView = UserInfo(viewModel: viewModel, coordinator: self)
        
        let userInfoVC = UIHostingController(rootView: userInfoView)
        push(userInfoVC, animate: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] isValid in
                if isValid {
                    self?.navigateToPetInfo()
                }
            })
            .store(in: &cancelBag)
    }
    
    func navigateToPetInfo() {
        print("Navigating to PetInfo")
        let petInfoCoordinator = PetInfoCoordinator(navigationController: navigationController)
        add(coordinator: petInfoCoordinator)
        petInfoCoordinator.start()
    }
    
    func navigateBack() {
        pop(animated: true)
    }
    
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    deinit {
        Logger().debug("UserInfoCoordinator Deinit \(self)")
    }
}
