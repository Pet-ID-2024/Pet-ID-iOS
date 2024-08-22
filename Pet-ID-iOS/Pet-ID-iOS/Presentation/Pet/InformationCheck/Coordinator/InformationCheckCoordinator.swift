import UIKit
import SwiftUI
import Combine

final class InformationCheckCoordinator: Coordinator {
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        showInformation()
        navigationBarHidden()
    }
    func showInformation(){
        let viewModel = InformationCheckViewModel()
        let informationCheckView = InformationCheck(viewModel: viewModel, coordinator: self)
        let informationCheckVC = UIHostingController(rootView: informationCheckView)
        navigationController.pushViewController(informationCheckVC, animated: true)
        
        viewModel.result.subject
            .sink { [weak self] result in
                switch result {
                case .next:
                    self?.navigateToSign()
                case .back:
                    self?.navigateBack()
                }
            }
            .store(in: &cancelBag)
    }
    
    func navigateToSign() {
        let viewModel = SignViewModel()
        let signView = Sign(viewModel: viewModel, coordinator: SignCoordinator(navigationController: UINavigationController()))
        let signVC = UIHostingController(rootView: signView)
        navigationController.pushViewController(signVC, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
