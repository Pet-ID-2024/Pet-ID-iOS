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
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: UserInfoState) {
        print("Handling UserInfoState: \(state)")
        switch state {
        case .valid:
            navigateToPetInfo()
        case .back:
            self.navigateBack()
        case .invalid:
            // Handle invalid state if needed
            print("Input is invalid")
        }
    }
    
    func navigateToPetInfo() {
        print("Navigating to PetInfo")
        let petInfoCoordinator = PetInfoCoordinator(navigationController: navigationController)
        add(coordinator: petInfoCoordinator)
        petInfoCoordinator.start()
    }
    
    func navigateBack() {
        print("Navigating back")
        pop(animated: true)
    }
    
//    func navigationBarHidden() {
//        navigationController.setNavigationBarHidden(hidden, animated: animated)
//    }
    
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    deinit {
        Logger().debug("UserInfoCoordinator Deinit \(self)")
    }
}
