import UIKit
import SwiftUI
import Combine

final class SignCoordinator: Coordinator {
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSign()
        navigationBarHidden()
    }
    
    func showSign() {
        let viewModel = SignViewModel()
        let signView = Sign(viewModel: viewModel, coordinator: self)
        let signVC = UIHostingController(rootView: signView)
        navigationController.pushViewController(signVC, animated: true)
        
        viewModel.result.subject
            .sink { [weak self ] result in
                switch result {
                case .completed:
                    self?.navigateToPCD()
                case .back:
                    self?.navigateBack()
                }
            }
            .store(in: &cancelBag)
    }
    
    func navigateToPCD() {
        let petCardDoneView = PetCardDone(viewModel: PetCardDoneViewModel(), coordinator: PetCardDoneCoordinator(navigationController: UINavigationController()))
        let petCardDoneVC = UIHostingController(rootView: petCardDoneView)
        navigationController.pushViewController(petCardDoneVC, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
