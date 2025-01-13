//import SwiftUI
//import Combine
//import UIKit
//
//final class PetCaptionCoordinator: Coordinator, ObservableObject, CameraViewControllerDelegate {
//
//    var id: String = UUID().uuidString
//    var finishDelegate: CoordinatorFinishDelegate?
//    var navigationController: UINavigationController
//    var childCoordinators: [String : any Coordinator] = [:]
//    private var cancelBag = Set<AnyCancellable>()
//    var temporaryData: [String: Any]
//
//    init(_ navigationController: UINavigationController, temporaryData: [String: Any]) {
//        self.navigationController = navigationController
//        self.temporaryData = temporaryData
//    }
//
//    func start() {
//        showPetCaption()
//    }
//
//    private func showPetCaption() {
//        let viewModel = PetCaptionViewModel(temporaryData: temporaryData)
//        let petCaptionView = PetCaption(viewModel: viewModel)
//        let petCaptionVC = BaseHostingViewController(rootView: petCaptionView)
//
//        // Push the view controller
//        push(petCaptionVC, animate: true)
//
//        viewModel.result.subject
//            .sink(receiveValue: { [weak self] state in
//                self?.handleStateSelection(state, updatedData: viewModel.temporaryData)
//            })
//            .store(in: &cancelBag)
//    }
//
//    private func handleStateSelection(_ state: PetCaptionState, updatedData: [String: Any]) {
//        switch state {
//        case .completed:
//            
//            Logger().debug("✅ 병합된 temporaryData: \(temporaryData)")
//            navigateToScanCheck()
//
//        case .nextStep:
//            Logger().debug("📌 Next step triggered")
//            navigateToCamera()
//
//        case .back:
//            navigateBack()
//        }
//    }
//
//    func navigateToScanCheck() {
//        let placeholderImage = UIImage(named: "hearticon") ?? UIImage()
//        let scanCoordinator = ScanCoordinator(navigationController, image: placeholderImage, temporaryData: temporaryData)
//        childCoordinators[scanCoordinator.id] = scanCoordinator
//        scanCoordinator.start()
//    }
//    
//    func navigateToCamera() {
//        let cameraVC = CameraViewController()
//        cameraVC.delegate = self
//        navigationController.present(cameraVC, animated: true)
//    }
//
//    func navigateBack() {
//        navigationController.popViewController(animated: true)
//    }
//
//    func cameraViewController(_ viewController: CameraViewController, didPickImage image: UIImage) {
//        Logger().debug("📸 Image picked (currently unused in this flow).")
//    }
//
//    func cameraViewControllerDidCancel(_ viewController: CameraViewController) {
//        Logger().debug("🚫 Camera cancelled")
//        navigateBack()
//    }
//
//    deinit {
//        Logger().debug("PetCaptionCoordinator Deinit \(self)")
//    }
//}
//
//extension PetCaptionCoordinator: CoordinatorFinishDelegate {
//    func coordinatorDidFinish(childCoordinator: any Coordinator) {
//        self.free(coordinator: childCoordinator)
//    }
//}


import UIKit
import Combine

final class PetCaptionCoordinator: Coordinator, ObservableObject {
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    var temporaryData: [String: Any]

    init(_ navigationController: UINavigationController, temporaryData: [String: Any]) {
        self.navigationController = navigationController
        self.temporaryData = temporaryData
    }

    func start() {
        showPetCaption()
    }

    private func showPetCaption() {
        let viewModel = PetCaptionViewModel(temporaryData: temporaryData)
        let petCaptionView = PetCaption(viewModel: viewModel)
        let petCaptionVC = BaseHostingViewController(rootView: petCaptionView)

        push(petCaptionVC, animate: true)

        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state, updatedData: viewModel.temporaryData)
            })
            .store(in: &cancelBag)
    }

    private func handleStateSelection(_ state: PetCaptionState, updatedData: [String: Any]) {
        switch state {
        case .completed:
            Logger().debug("✅ 병합된 temporaryData: \(temporaryData)")
            navigateToScanCheck()

        case .nextStep:
            navigateToCamera()

        case .back:
            navigateBack()
        }
    }

    func navigateToScanCheck() {
        let placeholderImage = UIImage(named: "hearticon") ?? UIImage()
        let scanCoordinator = ScanCoordinator(navigationController, image: placeholderImage, temporaryData: temporaryData)
        childCoordinators[scanCoordinator.id] = scanCoordinator
        scanCoordinator.start()
    }
    
    func navigateToCamera() {
        let cameraLauncher = CameraLauncher()
        cameraLauncher.delegate = self
        navigationController.present(cameraLauncher, animated: true)
    }

    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - CameraLauncherDelegate
extension PetCaptionCoordinator: CameraLauncherDelegate {
    func cameraLauncher(_ launcher: CameraLauncher, didCaptureImage image: UIImage) {
        Logger().debug("📸 캡처된 이미지: \(image)")
        temporaryData["capturedImage"] = image
        launcher.dismiss(animated: true) {
            self.showPetCaption()
        }
    }

    func cameraLauncherDidCancel(_ launcher: CameraLauncher) {
        Logger().debug("🚫 카메라 취소됨")
        launcher.dismiss(animated: true)
    }
}
