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
        showUserInfo()
        navigationBarHidden()
    }
    
    private func showUserInfo() {
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
        print("PetInfoCoordinator로 이동")
        let petInfoCoordinator = PetInfoCoordinator(navigationController: navigationController)
        add(coordinator: petInfoCoordinator)
        petInfoCoordinator.start()
    }
    
    func navigateBack() {
        print("뒤로 가기")
        navigationController.popViewController(animated: true)
    }
    
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func navigationBarHidden() {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        print("UserInfoCoordinator Deinit \(self)")
    }
}
