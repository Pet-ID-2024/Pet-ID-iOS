//import UIKit
//
//protocol CameraViewControllerDelegate: AnyObject {
//    func cameraViewController(_ viewController: CameraViewController, didPickImage image: UIImage)
//    func cameraViewControllerDidCancel(_ viewController: CameraViewController)
//}
//
//class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    weak var delegate: CameraViewControllerDelegate?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        Logger().debug("CameraViewController loaded.")
//        showCamera()
//    }
//    
//    private func showCamera() {
//        Logger().debug("Attempting to show camera.")
//        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//            Logger().error("Camera not available on this device.")
//            dismiss(animated: true, completion: nil)
//            return
//        }
//        
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .camera
//        imagePicker.allowsEditing = false
//        Logger().debug("Presenting UIImagePickerController for camera.")
//        present(imagePicker, animated: true, completion: {
//            Logger().info("UIImagePickerController presented successfully.")
//        })
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        Logger().info("User cancelled the camera.")
//        picker.dismiss(animated: true) {
//            self.delegate?.cameraViewControllerDidCancel(self)
//            Logger().debug("Dismissed UIImagePickerController after cancellation.")
//        }
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        Logger().debug("Finished picking media.")
//        if let image = info[.originalImage] as? UIImage {
//            Logger().info("Image picked successfully.")
//            picker.dismiss(animated: true) {
//                self.delegate?.cameraViewController(self, didPickImage: image)
//                Logger().debug("Dismissed UIImagePickerController after picking an image.")
//            }
//        } else {
//            Logger().error("Failed to retrieve the image.")
//            picker.dismiss(animated: true) {
//                self.delegate?.cameraViewControllerDidCancel(self)
//                Logger().debug("Dismissed UIImagePickerController after failing to pick an image.")
//            }
//        }
//    }
//}
