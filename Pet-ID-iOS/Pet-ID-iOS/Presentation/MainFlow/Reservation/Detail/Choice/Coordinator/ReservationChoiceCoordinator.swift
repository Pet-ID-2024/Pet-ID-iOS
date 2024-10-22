import SwiftUI
import Combine
import UIKit


final class ReservationChoiceCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showReservationChoiceView()
    }
    
    private func showReservationChoiceView() {
        let viewModel = ReservationChoiceViewModel()
        let reservationChoiceView = ReservationChoiceView(viewModel: viewModel)
        let reservationChoiceVC = BaseHostingViewController(rootView: reservationChoiceView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(reservationChoiceVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: ReservationChoiceState) {
        switch state {
        case .done:
            navigateToDoneView()
        case .back:
            navigateBack()
        }
    }
    
    func navigateToDoneView() {
        let reservationDoneCoordinator = ReservationDoneCoordinator(/*navigationController:*/ navigationController)
        childCoordinators[reservationDoneCoordinator.id] = reservationDoneCoordinator
        reservationDoneCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("ReservationChoiceCoordinator Deinit \(self)")
    }
}

extension ReservationChoiceCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
