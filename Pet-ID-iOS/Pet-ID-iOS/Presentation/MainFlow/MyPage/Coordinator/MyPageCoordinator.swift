import SwiftUI
import Combine
import UIKit


final class MyPageCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMyPageStart()
    }
    
    private func showMyPageStart() {
        let viewModel = MyPageViewModel()
        let myPageView = MyPageView(viewModel: viewModel)
        let myPageVC = BaseHostingViewController(rootView: myPageView)
        // TabBar 숨김 설정
//        myPageVC.hidesBottomBarWhenPushed = true
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(myPageVC, animate: true, isRoot: false)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: MyPageState) {
        switch state {
        case .userInfo:
            navigateToUserInfoDetail()
        case .petInfo:
            navigateToPetInfoDetail()
        case .reservation:
            navigateToReservationList()
        case .accessibilityRight:
            break
        case .privacyPolicy:
            break
        case .information:
            break
        case .qna:
            break
        case .withdraw:
            break
        }
    }
    
    func navigateToUserInfoDetail() {
        let userDetailCoordinator = UserInfoDetailCoordinator(/*navigationController:*/ navigationController)
        childCoordinators[userDetailCoordinator.id] = userDetailCoordinator
        userDetailCoordinator.start()
    }
    
    func navigateToPetInfoDetail() {
        let petDetailCoordinator = PetInfoDetailCoordinator(/*navigationController:*/ navigationController)
        childCoordinators[petDetailCoordinator.id] = petDetailCoordinator
        petDetailCoordinator.start()
    }
    
    func navigateToReservationList() {
        let reservationListCoordiator = ReservationListCoordinator(navigationController)
        childCoordinators[reservationListCoordiator.id] = reservationListCoordiator
        reservationListCoordiator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("MyPageCoordinator Deinit \(self)")
    }
}

extension MyPageCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
