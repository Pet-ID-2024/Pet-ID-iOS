//
//  PetCaptionCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/5/24.
//

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
    
    func showPetCaption() {
        let viewModel = PetCaptionViewModel()
        let petCaptionView = PetCaption(viewModel: viewModel, coordinator: self)
        
        viewModel.result.subject
            .sink(receiveValue: {[weak self] result in
                switch result {
                case .completed:
                    self?.finish()
                case .nextStep:
                    self?.navigateToCamera()
                case .back:
                    self?.pop(animated: true)
                }
            })
            .store(in: &cancelBag)
        
        let petCaptionVC = UIHostingController(rootView: petCaptionView)
        navigationController.pushViewController(petCaptionVC, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToCamera() {
        let cameraVC = CameraViewController()
        cameraVC.delegate = self
        navigationController.present(cameraVC, animated: true, completion: nil)
    }
    
    func navigationBarHidden(_ hidden: Bool, animated: Bool = false) {
        navigationController.setNavigationBarHidden(hidden, animated: animated)
    }
    
    func navigateToScanCheck(with image: UIImage) {
        let scanCheckCoordinator = ScanCheckCoordinator(navigationController: navigationController, image: image)
        childCoordinators[scanCheckCoordinator.id] = scanCheckCoordinator
                scanCheckCoordinator.start()
    }
    
    deinit {
        Logger().debug("Coordinator Deinit \(self)")
    }
}

extension PetCaptionCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            self?.navigateBack()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true) { [weak self] in
                self?.navigateToScanCheck(with: image)
            }
        }else {
            picker.dismiss(animated: true) { [weak self] in
                self?.navigateBack()
            }
        }
    }
    
}
