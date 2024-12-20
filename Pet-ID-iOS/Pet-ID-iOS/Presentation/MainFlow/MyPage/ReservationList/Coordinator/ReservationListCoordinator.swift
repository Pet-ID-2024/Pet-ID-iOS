import SwiftUI
import Combine
import UIKit


final class ReservationListCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    private var viewModel: ReservationListViewModel!
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showReservationList()
    }
    
    private func showReservationList() {
        viewModel = ReservationListViewModel()
        let reservationListView = ReservationListView(viewModel: viewModel)
        let reservationListVC = BaseHostingViewController(rootView: reservationListView)
        // TabBar 숨김 설정
        //        myPageVC.hidesBottomBarWhenPushed = true
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(reservationListVC, animate: true, isRoot: false)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: ReservationListState) {
        switch state {
        case .back:
            navigateBack()
            //        case .showCancellationSuccess:
            //            Logger().debug("✅ 예약 취소 처리")
            //            navigationController.dismiss(animated: true)
        }
    }
    
    func showCancelDialog(for reservation: ReservationList) {
        let dialogCoordinator = Dialog3Coordinator(navigationController: navigationController, fetcher: DefaultReservationListFetcher(), title: "예약을 취소하시겠습니까?", orderId: reservation.id, onSuccess: { [ weak self ] in
            self?.removeReservation(reservation)
        }
        )
        childCoordinators[dialogCoordinator.id] = dialogCoordinator
        dialogCoordinator.start()
    }
    
    func removeReservation(_ reservation: ReservationList) {
        viewModel.reservations.removeAll { $0.id == reservation.id }
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("ReservationListCoordinator Deinit \(self)")
    }
}

extension ReservationListCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
