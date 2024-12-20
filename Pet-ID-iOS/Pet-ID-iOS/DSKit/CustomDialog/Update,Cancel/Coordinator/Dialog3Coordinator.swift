//
//  Dialog3Coordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/11/24.
//

import Foundation
import SwiftUI
import Combine
import UIKit

final class Dialog3Coordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    private let fetcher: ReservationListFetcher
    private let orderId: Int
    private let title: String
    private var onSuccess: (() -> Void)?
    
    init(
        navigationController: UINavigationController,
        fetcher: ReservationListFetcher,
        title: String,
        orderId: Int,
        onSuccess: (() -> Void)? = nil
    ) {
        self.navigationController = navigationController
        self.title = title
        self.fetcher = fetcher
        self.orderId = orderId
        self.onSuccess = onSuccess
    }
    
    func start() {
        showDialog3()
    }
    
    private func showDialog3() {
        let viewModel = Dialog3ViewModel(fetcher: fetcher, title: title, orderId: orderId, onSuccess: onSuccess)
        let dialog3View = Dialog3(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: dialog3View)
        
        hostingController.modalPresentationStyle = .overFullScreen
        hostingController.modalTransitionStyle = .crossDissolve
        
        navigationController.present(hostingController, animated: true)
        
        viewModel.$isPresented
            .sink(receiveValue: { [weak self] isPresented in
                if !isPresented {
                    self?.navigationController.dismiss(animated: true)
                }
            })
            .store(in: &cancelBag)
    }
    
    deinit {
        Logger().debug("Dialog3Coordinator Deinit \(self)")
    }
}

extension Dialog3Coordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
