import SwiftUI
import Combine
import UIKit


final class PetCardStartCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    private var temporaryData: [String: Any] = [:]
    
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
        
        push(petCardStartVC, animate: true/*, isRoot: true*/)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state, chipType: viewModel.temporaryData["chipType"] as? String)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: PetRegistrationState, chipType: String?) {
        switch state {
        case .unregistered, .externalChip, .internalChip:
            if let chipType = chipType {
                            temporaryData["chipType"] = chipType
                            navigateToUserInfo()
                        } else {
                            Logger().error("❌ 칩 타입이 전달되지 않았습니다.")
                        }
        case .back:
            navigateBack()
        }
    }
    
    func navigateToUserInfo() {
        let userInfoCoordinator = UserInfoCoordinator(/*navigationController:*/ navigationController, temporaryData: temporaryData)
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
