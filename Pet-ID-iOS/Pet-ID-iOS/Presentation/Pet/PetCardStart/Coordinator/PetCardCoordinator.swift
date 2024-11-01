import SwiftUI
import Combine
import UIKit


final class PetCardStartCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showPetCardStart()
    }
    
    private func showPetCardStart() {
        let viewModel = PetCardStartViewModel()
        let petCardStartView = PetCardStart(viewModel: viewModel, coordinator: self)
        let petCardStartVC = BaseHostingViewController(rootView: petCardStartView)
        // TabBar 숨김 설정
            petCardStartVC.hidesBottomBarWhenPushed = true
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(petCardStartVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
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
        let userInfoCoordinator = UserInfoCoordinator(/*navigationController:*/ navigationController)
        childCoordinators[userInfoCoordinator.id] = userInfoCoordinator
        userInfoCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("PetCardStartCoordinator Deinit \(self)")
    }
}

extension PetCardStartCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
