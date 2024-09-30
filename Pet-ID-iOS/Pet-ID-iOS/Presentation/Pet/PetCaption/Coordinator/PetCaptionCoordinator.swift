import UIKit
import SwiftUI
import Combine

final class PetCaptionCoordinator: NSObject, Coordinator {
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
        navigationBarHidden(true)
    }
    
    private func showPetCaption() {
//        let viewModel = PetCaptionViewModel()
//        let petCaptionView = PetCaption(viewModel: viewModel, coordinator: self)
//        
//        viewModel.result.subject
//            .sink(receiveValue: { [weak self] result in
//                switch result {
//                case .completed:
//                    break
//                case .nextStep:
//                    self?.navigateToCamera()
//                case .back:
//                    self?.navigateBack()
//                }
//            })
//            .store(in: &cancelBag)
//        
//        let petCaptionVC = UIHostingController(rootView: petCaptionView)
//        navigationController.pushViewController(petCaptionVC, animated: true)
        let viewModel = PetCaptionViewModel()
        let petCaptionVC = UIHostingController(rootView: PetCaption(viewModel: viewModel, coordinator: self))
        push(petCaptionVC, animate: true)
        
        viewModel.result.subject.sink(receiveValue: {[weak self] state in
            self?.petCaptionStateSelection(state)
        }).store(in: &cancelBag)
    }
    
    private func petCaptionStateSelection(_ state: PetCaptionViewModelResult) {
        switch state {
        case .completed:
            navigateToCamera()
        case .back:
            navigateBack()
        case .nextStep:
            print("뒤로가기")
        }
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToCamera() {
        let cameraVC = CameraViewController()
        cameraVC.delegate = self
        navigationController.present(cameraVC, animated: true, completion: nil)
    }
    
    func navigateToScanCheck(with image: UIImage) {
        let scanCheckCoordinator = ScanCheckCoordinator(navigationController: navigationController, image: image)
        childCoordinators[scanCheckCoordinator.id] = scanCheckCoordinator
        scanCheckCoordinator.start()
    }
    
    func navigationBarHidden(_ hidden: Bool, animated: Bool = false) {
        navigationController.setNavigationBarHidden(hidden, animated: animated)
    }
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}

extension PetCaptionCoordinator: CameraViewControllerDelegate {
    func cameraViewController(_ viewController: CameraViewController, didPickImage image: UIImage) {
        navigateToScanCheck(with: image)
    }
    
    func cameraViewControllerDidCancel(_ viewController: CameraViewController) {
        navigateBack()
    }
}
