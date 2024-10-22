import SwiftUI
import Combine
import UIKit


final class PetCaptionCoordinator: Coordinator, ObservableObject, CameraViewControllerDelegate {
    
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showPetCaption()
    }
    
    private func showPetCaption() {
        let viewModel = PetCaptionViewModel()
        let petCaptionView = PetCaption(viewModel: viewModel)
        let petCaptionVC = BaseHostingViewController(rootView: petCaptionView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(petCaptionVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: PetCaptionState) {
        switch state {
        case .completed:
//            navigateToCamera()
            navigateToScanCheck(with: UIImage())
        case .nextStep:
//            navigateToScanCheck(with: UIImage())
            break
        case .back:
            navigateBack()
        }
    }
    
    func navigateToCamera() {
        let cameraVC = CameraViewController()
        cameraVC.delegate = self
        navigationController.present(cameraVC, animated: true, completion: nil)
    }
    
    func navigateToScanCheck(with image: UIImage) {
        let scanCoordinator = ScanCoordinator(/*navigationController: */navigationController, image: UIImage())
        childCoordinators[scanCoordinator.id] = scanCoordinator
        scanCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    func cameraViewController(_ viewController: CameraViewController, didPickImage image: UIImage) {
        navigateToScanCheck(with: image)
    }
    
    func cameraViewControllerDidCancel(_ viewController: CameraViewController) {
        navigateBack()
    }
    
    deinit {
        Logger().debug("PetCaptionCoordinator Deinit \(self)")
    }
}

extension PetCaptionCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
