import UIKit

protocol CameraViewControllerDelegate: AnyObject {
    func cameraViewController(_ viewController: CameraViewController, didPickImage image: UIImage)
    func cameraViewControllerDidCancel(_ viewController: CameraViewController)
}

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var delegate: CameraViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCamera()
    }
    
    private func showCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            dismiss(animated: true, completion: nil)
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.delegate?.cameraViewControllerDidCancel(self)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            // 이미지를 선택했을 때 delegate 호출
            picker.dismiss(animated: true) {
                self.delegate?.cameraViewController(self, didPickImage: image)
            }
        } else {
            // 이미지 선택이 실패했을 때 delegate 호출
            picker.dismiss(animated: true) {
                self.delegate?.cameraViewControllerDidCancel(self)
            }
        }
    }
}
