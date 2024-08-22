import UIKit
import SwiftUI

final class ScanCheckCoordinator: Coordinator {
    var finishDelegate: (any CoordinatorFinishDelegate)?
    
    var id: String = UUID().uuidString
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private let image: UIImage
    
    init(navigationController: UINavigationController, image: UIImage) {
        self.navigationController = navigationController
        self.image = image
    }
    
    func start() {
        showScanCheck()
        navigationBarHidden()
    }
    func showScanCheck(){
        let viewModel = ScanCheckViewModel(image: image)
        let scanCheckView = ScanCheck(viewModel: viewModel, coordinator: self)
        let scanCheckVC = UIHostingController(rootView: scanCheckView)
        navigationController.pushViewController(scanCheckVC, animated: true)
    }
    
    func navigateToIC() {
        let viewModel = InformationCheckViewModel()
        let ICView = InformationCheck(viewModel: viewModel, coordinator: InformationCheckCoordinator(navigationController: UINavigationController()))
        let informationVC = UIHostingController(rootView: ICView)
        navigationController.pushViewController(informationVC, animated: true)
        
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
