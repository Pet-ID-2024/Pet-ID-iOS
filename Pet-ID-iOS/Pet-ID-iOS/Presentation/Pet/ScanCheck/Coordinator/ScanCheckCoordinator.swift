import SwiftUI
import Combine
import UIKit


final class ScanCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    private let image: UIImage
    
    init(_ navigationController: UINavigationController, image: UIImage) {
        self.navigationController = navigationController
        self.image = image
    }
    
    func start() {
        showScanCheck()
    }
    
    private func showScanCheck() {
        let viewModel = ScanCheckViewModel(image: image)
        let ScanCheckView = ScanCheck(viewModel: viewModel)
        let ScanCheckVC = BaseHostingViewController(rootView: ScanCheckView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(ScanCheckVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: ScanCheckState) {
        switch state {
        case .next:
            navigateToIC()
        case .back:
            navigateBack()
        }
    }
    
    func navigateToIC() {
        let InformationCheckCoordinator = InformationCoordinator(/*navigationController: */navigationController)
        childCoordinators[InformationCheckCoordinator.id] = InformationCheckCoordinator
        InformationCheckCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("ScanCoordinator Deinit \(self)")
    }
}

extension ScanCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
