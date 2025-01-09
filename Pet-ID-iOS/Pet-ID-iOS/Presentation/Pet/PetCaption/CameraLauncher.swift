import UIKit
import AVFoundation
import Combine

protocol CameraLauncherDelegate: AnyObject {
    func cameraLauncher(_ launcher: CameraLauncher, didCaptureImage image: UIImage)
    func cameraLauncherDidCancel(_ launcher: CameraLauncher)
}

final class CameraLauncher: UIViewController {
    weak var delegate: CameraLauncherDelegate?
    private var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Logger().debug("✅ CameraLauncher viewDidLoad 호출됨")
        requestCameraAuthorization()
    }

    private func requestCameraAuthorization() {
        Logger().debug("📡 카메라 권한 요청 시작")
        CameraAlbumManager.shared.requestCameraAuthorization()
            .sink { [weak self] authorized in
                guard let self = self else {
                    Logger().error("❌ self가 nil임 - 권한 요청 중단")
                    return
                }
                if authorized {
                    Logger().debug("✅ 카메라 권한 허용됨")
                    self.openCamera()
                } else {
                    Logger().error("❌ 카메라 권한 거부됨")
                    self.showAuthorizationAlert()
                }
            }
            .store(in: &cancelBag)
    }

    private func openCamera() {
        Logger().debug("📸 openCamera 호출됨")

        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            Logger().error("❌ 카메라 사용 불가")
            showCameraUnavailableAlert()
            return
        }

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        Logger().debug("✅ UIImagePickerController 설정 완료")

        DispatchQueue.main.async {
            if self.isViewLoaded && self.view.window != nil {
                self.present(imagePicker, animated: true) {
                    Logger().debug("✅ UIImagePickerController가 성공적으로 표시됨")
                }
            } else {
                Logger().error("❌ CameraLauncher 뷰가 window hierarchy에 추가되지 않음")
            }
        }
    }

    private func showAuthorizationAlert() {
        Logger().debug("⚠️ 권한 알림 표시 중")
        let alert = UIAlertController(
            title: "카메라 권한 필요",
            message: "설정에서 카메라 권한을 허용해주세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default, handler: { _ in
            Logger().debug("🔄 설정으로 이동 요청")
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true) {
            Logger().debug("✅ 권한 알림이 표시됨")
        }
    }

    private func showCameraUnavailableAlert() {
        Logger().error("❌ 카메라 사용 불가 경고 표시")
        let alert = UIAlertController(
            title: "카메라 사용 불가",
            message: "이 기기에서는 카메라를 사용할 수 없습니다.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true) {
            Logger().debug("✅ 카메라 사용 불가 알림이 표시됨")
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CameraLauncher: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Logger().debug("🚫 사용자가 촬영을 취소함")
        picker.dismiss(animated: true) {
            Logger().debug("✅ UIImagePickerController가 닫혔음 (취소)")
            self.delegate?.cameraLauncherDidCancel(self)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        Logger().debug("📸 이미지 캡처 완료")
        if let image = info[.originalImage] as? UIImage {
            Logger().debug("✅ 캡처된 이미지: \(image)")
            picker.dismiss(animated: true) {
                Logger().debug("✅ UIImagePickerController가 닫혔음 (이미지 선택)")
                self.delegate?.cameraLauncher(self, didCaptureImage: image)
            }
        } else {
            Logger().error("❌ 이미지 캡처 실패")
            picker.dismiss(animated: true) {
                Logger().debug("✅ UIImagePickerController가 닫혔음 (이미지 없음)")
            }
        }
    }
}
