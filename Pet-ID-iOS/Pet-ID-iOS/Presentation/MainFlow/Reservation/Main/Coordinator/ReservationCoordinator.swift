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
        let reservationVC = BaseHostingViewController(rootView: ReservationMainView(viewModel: viewModel))
        push(reservationVC, animate: false, isRoot: false)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state, viewModel: viewModel)
            })
            .store(in: &cancelBag)
    }
    
    
    private func handleStateSelection(_ state: ReservationMainState, viewModel: ReservationMainViewModel) {
        switch state {
        case .selectHospital:
            if let selectedHospital = viewModel.selectedHospital {
                navigateToDetail(with: selectedHospital)
            } else {
                print("Error: 선택된 병원이 없습니다.")
            }
        case .search:
            break
        }
    }
    
    func navigateToDetail(with hospital: Hospital) {
        Task {
            do {
                // 병원 상세 정보 가져오기
                let detailedHospital = try await ReservationMainViewModel().hospitalFetcher.getHospitalDetail(hospitalId: hospital.id)
                
                // 상세 정보 기반으로 코디네이터 초기화 및 화면 이동
                let detailCoordinator = ReservationDetailCoordinator(navigationController, hospital: detailedHospital)
                childCoordinators[detailCoordinator.id] = detailCoordinator
                detailCoordinator.start()
            } catch {
                print("Error: 병원 상세 정보 로드 실패 - \(error.localizedDescription)")
            }
        }
    }
}



//
//extension HomeCoordinator: CoordinatorFinishDelegate {
//    func coordinatorDidFinish(childCoordinator: any Coordinator) {
//        self.free(coordinator: childCoordinator)
//    }
//}
