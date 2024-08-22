import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    
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
        dismiss(animated: true) {
            self.delegate?.imagePickerControllerDidCancel?(picker) // 취소 시 델리게이트 호출
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            dismiss(animated: true) {
                self.delegate?.imagePickerController?(picker, didFinishPickingMediaWithInfo: info) // 이미지 선택 시 델리게이트 호출
            }
        } else {
            dismiss(animated: true) {
                self.delegate?.imagePickerControllerDidCancel?(picker) // 이미지 선택 실패 시 델리게이트 호출
            }
        }
    }
}
