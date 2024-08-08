//
//  PetInfoCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/4/24.
//

import Combine
import SwiftUI


protocol PetInfoFinishDelegate: AnyObject {
    func finish(result: PetInfoViewModelResult)
}

final class PetInfoCoordinator: Coordinator {
    
    // 필수 프로퍼티들
    var id: String = UUID().uuidString
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    weak var petInfoFinishDelegate: PetInfoFinishDelegate?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        showPetInfo()
        navigationBarHidden()
    }
    
    func showPetInfo() {
        let viewModel = PetInfoViewModel()
        let petInfoVC = UIHostingController(
            rootView: PetInfo()
        )
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .petCaption:
                    self?.showPetCaption()
                case .back:
                    self?.pop(animated: true)
                }
            }).store(in: &cancelBag)
        
        push(petInfoVC, animate: false, isRoot: true)
    }
    
    func showPetCaption() {
        let viewModel = PetCaptionViewModel()
        let petCaptionVC = UIHostingController(
            rootView: PetCaption(viewModel: viewModel, coordinator: PetCaptionCoordinator(navigationController: UINavigationController()))
        )
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .nextStep:
                    
                    self?.finish()
                case .back:
                    self?.navigateBack()
                case .completed:
                    self?.finishDelegate
                }
            }).store(in: &cancelBag)
        
        push(petCaptionVC)
    }
    
    func navigateBack() {
        pop(animated: true)
    }
    
//    func navigationBarHidden() {
//        navigationController.setNavigationBarHidden(hidden, animated: animated)
//    }
    
    deinit {
        Logger().debug("PetInfoCoordinator Deinit \(self)")
    }
}
