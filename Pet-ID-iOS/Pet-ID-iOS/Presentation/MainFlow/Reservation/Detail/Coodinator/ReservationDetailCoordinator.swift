import SwiftUI
import Combine
import UIKit


final class ReservationDetailCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    private let hospital: Hospital
    
    init(_ navigationController: UINavigationController, hospital: Hospital) {
        self.navigationController = navigationController
        self.hospital = hospital
    }
    
    func start() {
        showReservationDetailView()
    }
    
    private func showReservationDetailView() {
        let viewModel = ReservationDetailViewModel(hospital: hospital)
        let reservationDetailView = ReservationDetailView(viewModel: viewModel)
        let reservationDetailVC = BaseHostingViewController(rootView: reservationDetailView)
        reservationDetailVC.hidesBottomBarWhenPushed = true
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(reservationDetailVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: ReservationDetailState) {
        switch state {
        case .reservation:
            navigateToReservationView()
        case .back:
            navigateBack()
        }
    }
    
    func navigateToReservationView() {
        let reservationChoiceCoordinator = ReservationChoiceCoordinator(/*navigationController:*/ navigationController, hospital: hospital)
        childCoordinators[reservationChoiceCoordinator.id] = reservationChoiceCoordinator
        reservationChoiceCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("ReservationDetailCoordinator Deinit \(self)")
    }
}

extension ReservationDetailCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
