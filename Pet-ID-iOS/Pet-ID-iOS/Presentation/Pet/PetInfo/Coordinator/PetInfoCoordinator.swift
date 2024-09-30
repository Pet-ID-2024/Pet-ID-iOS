//
//  PetInfoCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/4/24.
//

import Combine
import SwiftUI


//protocol PetInfoFinishDelegate: AnyObject {
//    func finish(result: PetInfoViewModelResult)
//}

final class PetInfoCoordinator: Coordinator {
    
    // 필수 프로퍼티들
    var id: String = UUID().uuidString
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
//    weak var petInfoFinishDelegate: PetInfoFinishDelegate?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        showPetInfo()
        navigationBarHidden()
    }
    
    private func showPetInfo() {
        let viewModel = PetInfoViewModel()
        let petInfoVC = UIHostingController(
            rootView: PetInfo(viewModel: viewModel, coordinator: self)
        )
        push(petInfoVC, animate: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.petInfoStateSelection(state)
            }).store(in: &cancelBag)
    }
    
    private func petInfoStateSelection(_ state: PetInfoViewModelResult) {
        switch state {
        case .back:
            navigateBack()
        case .valid:
            showPetCaption()
        case .invalid:
            print("Input is invalid")
            
        }
    }
    
    func showPetCaption() {
//        let petCaptionCoordinator = PetCaptionCoordinator(navigationController: navigationController)
//        add(coordinator: petCaptionCoordinator)
//        petCaptionCoordinator.start()
        
        //        viewModel.result.subject
        //            .sink(receiveValue: { [weak self] result in
        //                switch result {
        //                case .nextStep:
        //                    self?.finish()
        //                case .back:
        //                    self?.navigateBack()
        //                case .completed:
        //                    self?.finishDelegate
        //                }
        //            }).store(in: &cancelBag)
        //
        //        push(petCaptionVC)
        
        let petCaptionCoordinator = PetCaptionCoordinator(navigationController: navigationController) // 기존 내비게이션 컨트롤러 사용
        childCoordinators[petCaptionCoordinator.id] = petCaptionCoordinator // 자식 코디네이터 추가
        petCaptionCoordinator.start() // 코디네이터 시작
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
        func navigationBarHidden() {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    
    
    
    deinit {
        Logger().debug("PetInfoCoordinator Deinit \(self)")
    }
}

extension PetInfoCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
