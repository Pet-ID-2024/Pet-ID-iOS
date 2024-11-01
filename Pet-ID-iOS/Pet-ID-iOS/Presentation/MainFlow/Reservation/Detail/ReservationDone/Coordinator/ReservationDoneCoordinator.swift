import SwiftUI
import Combine
import UIKit


final class ReservationDoneCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showReservationDone()
    }
    
    private func showReservationDone() {
        let viewModel = ReservationDoneViewModel()
        let showReservationDone = ReservationDoneView(viewModel: viewModel)
        let showReservationDoneVC = BaseHostingViewController(rootView: showReservationDone)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(showReservationDoneVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: ReservationDoneState) {
        switch state {
        case .done:
            navigateToMain()
        case .back:
            navigateBack()
        }
    }
    
//    func navigateToMain() {
//        let homeCoordinator = HomeCoordinator(navigationController)
//        childCoordinators[homeCoordinator.id] = homeCoordinator
//        homeCoordinator.start()
//
//        navigationController.tabBarController?.tabBar.isHidden = false
//        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
//    }
    func navigateToMain() {
        if let tabBarController = navigationController.tabBarController {
                tabBarController.selectedIndex = 0  // 원하는 탭으로 이동 (예: Home 탭)
            }
        navigationController.popToRootViewController(animated: true)  // 최상위 뷰로 돌아가기
            finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("ReservationDoneCoordinator Deinit \(self)")
    }
}

extension ReservationDoneCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
