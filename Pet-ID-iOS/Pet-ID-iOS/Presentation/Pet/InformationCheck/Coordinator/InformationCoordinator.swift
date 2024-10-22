import SwiftUI
import Combine
import UIKit


final class InformationCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showInformation()
    }
    
    private func showInformation() {
        let viewModel = InformationCheckViewModel()
        let InformationCheckView = InformationCheck(viewModel: viewModel)
        let InformationCheckVC = BaseHostingViewController(rootView: InformationCheckView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(InformationCheckVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: InformationCheckState) {
        switch state {
        case .next:
            navigateToSign()
        case .back:
            navigateBack()
        }
    }
    
    func navigateToSign() {
        let signCoordinator = SignCoordinator(/*navigationController: */navigationController)
        childCoordinators[signCoordinator.id] = signCoordinator
        signCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("InformationCoordinator Deinit \(self)")
    }
}

extension InformationCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
