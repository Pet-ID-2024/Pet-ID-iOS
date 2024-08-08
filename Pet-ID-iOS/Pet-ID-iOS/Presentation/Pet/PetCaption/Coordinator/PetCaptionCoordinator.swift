//
//  PetCaptionCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/5/24.
//

import UIKit
import SwiftUI
import Combine

final class PetCaptionCoordinator: Coordinator {
    var id: String = UUID().uuidString
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showPetCaption()
        navigationBarHidden()
    }
    
    private func showPetCaption() {
        let viewModel = PetCaptionViewModel()
        let petCaptionView = PetCaption(viewModel: viewModel, coordinator: self)
        
        viewModel.result.subject
            .sink(receiveValue: {[weak self] result in
                switch result {
                case .completed:
                    self?.finish()
                case .nextStep:
                    break
                case .back:
                    self?.pop(animated: true)
                }
            })
            .store(in: &cancelBag)
        
        let petCaptionVC = UIHostingController(rootView: petCaptionView)
        navigationController.pushViewController(petCaptionVC, animated: true)
    }
    
    func navigateBack() {
        pop(animated: true)
    }
    
    func navigationBarHidden(_ hidden: Bool, animated: Bool = false) {
        navigationController.setNavigationBarHidden(hidden, animated: animated)
    }
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}
