//
//  ReservationCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation
import Combine
import SwiftUI

final class ReservationCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showReservation()
    }
    
    private func showReservation() {
        let viewModel = ReservationMainViewModel()
        let homeVC = BaseHostingViewController(rootView: ReservationMainView(viewModel: viewModel))
        push(homeVC, animate: false, isRoot: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
        
    
    private func handleStateSelection(_ state: ReservationMainState) {
        switch state {
        case .selectHospital:
            navigateToDetail()
        case .search:
            break
        }
    }
    
    func navigateToDetail() {
        let detailCoordinator = ReservationDetailCoordinator(/*navigationController:*/ navigationController)
        childCoordinators[detailCoordinator.id] = detailCoordinator
        detailCoordinator.start()
    }
    
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}
//
//extension HomeCoordinator: CoordinatorFinishDelegate {
//    func coordinatorDidFinish(childCoordinator: any Coordinator) {
//        self.free(coordinator: childCoordinator)
//    }
//}
