//
//  Dialog1Coordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/11/24.
//

import Foundation
import SwiftUI
import Combine
import UIKit

final class Dialog1Coordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        
    }
    
    func start() {
        showDialog1()
    }
    
    private func showDialog1() {
        let viewModel = Dialog1ViewModel()
        let dialog1View = Dialog1(viewModel: viewModel)
        let dialog1VC = BaseHostingViewController(rootView: dialog1View)
        
        push(dialog1VC, animate: true, isRoot: false)
        
        viewModel.result.subject
            .sink(receiveValue: { [ weak self ] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: Dialog1State) {
        switch state {
        case .hospital:
            navigateToHospital()
        }
    }
    
    func navigateToHospital() {
        
    }
    
    deinit {
        Logger().debug("Dialog1Coordinator Deinit \(self)")
    }
}

extension Dialog1Coordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
