import SwiftUI
import Combine
import UIKit

final class PetCaptionCoordinator: Coordinator, ObservableObject, CameraViewControllerDelegate {

    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
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

        // Push the view controller
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
            Logger().debug("✅ 병합 전 temporaryData: \(temporaryData)")
            
            // Add petImages
            let testImages = [
                        PetImageRequestDTO(imagePath: "petImage/test666"),
                        PetImageRequestDTO(imagePath: "petImage/test777")
                    ]
            temporaryData["petImages"] = testImages.map { ["imagePath": $0.imagePath] }
            
            Logger().debug("✅ 병합된 temporaryData: \(temporaryData)")
            navigateToScanCheck()

        case .nextStep:
            Logger().debug("📌 Next step triggered")
            break

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

    func navigateBack() {
        navigationController.popViewController(animated: true)
    }

    func cameraViewController(_ viewController: CameraViewController, didPickImage image: UIImage) {
        Logger().debug("📸 Image picked (currently unused in this flow).")
    }

    func cameraViewControllerDidCancel(_ viewController: CameraViewController) {
        Logger().debug("🚫 Camera cancelled")
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
