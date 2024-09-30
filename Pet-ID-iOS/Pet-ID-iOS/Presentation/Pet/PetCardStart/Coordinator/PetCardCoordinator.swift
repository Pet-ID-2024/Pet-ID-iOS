import SwiftUI
import Combine
import UIKit


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
        //        let userInfoView = UserInfo(viewModel: UserInfoViewModel(), coordinator: UserInfoCoordinator(navigationController: UINavigationController()))
        //        let userInfoVC = UIHostingController(rootView: userInfoView)
        //        navigationController.pushViewController(userInfoVC, animated: true)
//        let memberService = MemberService()
        let userInfoCoordinator = UserInfoCoordinator(navigationController: navigationController/*, memberService:memberService*/) // 기존 내비게이션 컨트롤러 사용
        childCoordinators[userInfoCoordinator.id] = userInfoCoordinator // 자식 코디네이터 추가
        userInfoCoordinator.start() // 코디네이터 시작
        
    }
    
    //    func showPetCardView() {
    //        let petCardView = PetCardStart(viewModel: PetCardStartViewModel(), coordinator: PetCardStartCoordinator(navigationController: UINavigationController()))
    //            let petCardVC = UIHostingController(rootView: petCardView)
    //            navigationController.pushViewController(petCardVC, animated: true)
    //        }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    func navigationBarHidden() {
        navigationController.setNavigationBarHidden(true, animated: false)
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
