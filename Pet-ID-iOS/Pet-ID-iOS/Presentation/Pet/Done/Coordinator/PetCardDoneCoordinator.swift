import SwiftUI
import Combine
import UIKit

final class PetCardDoneCoordinator: Coordinator {
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showPetCardDone()
        navigationBarHidden()
    }
    
    func showPetCardDone() {
        let viewModel = PetCardDoneViewModel()
        let petCardDoneView = PetCardDone(viewModel: viewModel, coordinator: self)
        
        let PetCardDoneVC = UIHostingController(rootView: petCardDoneView)
        push(PetCardDoneVC, animate: true)
        
        viewModel.result.subject
                    .sink(receiveValue: { [weak self] result in
                        switch result {
                        case .done:
                            self?.navigateToMain()
                        case .back:
                            self?.navigateBack()
                        }
                    })
                    .store(in: &cancelBag)
    }
    
    func navigateToMain() {
        finish()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    func finish() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    deinit {
            Logger().debug("PetCardDoneCoordinator Deinit \(self)")
        }
}
