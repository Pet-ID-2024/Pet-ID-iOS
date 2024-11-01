import SwiftUI
import Combine
import UIKit


final class UserInfoCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showUserInfo()
    }
    
    private func showUserInfo() {
        let viewModel = UserInfoViewModel()
        let userInfoView = UserInfo(viewModel: viewModel)
        let userInfoVC = BaseHostingViewController(rootView: userInfoView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(userInfoVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: UserInfoState) {
        switch state {
        case .valid:
            navigateToPetInfo()
        case .invalid:
            print("Input is invalid")
        case .back:
            navigateBack()
        }
    }
    
    func navigateToPetInfo() {
        let petInfoCoordinator = PetInfoCoordinator(/*navigationController:*/ navigationController)
        childCoordinators[petInfoCoordinator.id] = petInfoCoordinator
        petInfoCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("UserInfoCoordinator Deinit \(self)")
    }
}

extension UserInfoCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
