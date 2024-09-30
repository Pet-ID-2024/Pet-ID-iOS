import SwiftUI
import Combine
import UIKit

final class UserInfoCoordinator: Coordinator {
    var id: String = UUID().uuidString
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
//    private let memberService: MemberService
    
    init(navigationController: UINavigationController/*, memberService: MemberService*/) {
        self.navigationController = navigationController
//        self.memberService = memberService
    }
    
    func start() {
        showUserInfo()
        navigationBarHidden()
    }
    
    private func showUserInfo() {
        let viewModel = UserInfoViewModel(/*memberService: memberService*/)
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
            navigateBack()
        case .invalid:
            // Handle invalid state if needed
            print("Input is invalid")
        }
    }
    
    func navigateToPetInfo() {
//        print("PetInfoCoordinator로 이동")
//        let petInfoCoordinator = PetInfoCoordinator(navigationController: navigationController)
//        add(coordinator: petInfoCoordinator)
//        petInfoCoordinator.start()
//        let petInfoView = PetInfo(viewModel: PetInfoViewModel(), coordinator: PetInfoCoordinator(navigationController: UINavigationController()))
//        let petInfoVC = UIHostingController(rootView: petInfoView)
//        navigationController.pushViewController(petInfoVC, animated: true)
        let petInfoCoordinator = PetInfoCoordinator(navigationController: navigationController) // 기존 내비게이션 컨트롤러 사용
        childCoordinators[petInfoCoordinator.id] = petInfoCoordinator // 자식 코디네이터 추가
        petInfoCoordinator.start() // 코디네이터 시작
    }
    
    
    func navigateBack() {
        print("뒤로 가기")
        navigationController.popViewController(animated: true)
//        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func navigationBarHidden() {
        navigationController.setNavigationBarHidden(true, animated: false)
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
