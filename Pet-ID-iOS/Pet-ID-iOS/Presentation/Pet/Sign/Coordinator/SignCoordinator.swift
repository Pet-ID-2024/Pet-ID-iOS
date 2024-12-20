import SwiftUI
import Combine
import UIKit


final class SignCoordinator: Coordinator, ObservableObject {
    
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
        showSign()
    }
    
    private func showSign() {
        let viewModel = SignViewModel(temporaryData: temporaryData)
        let signView = Sign(viewModel: viewModel)
        let signVC = BaseHostingViewController(rootView: signView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(signVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state, updatedData: viewModel.temporaryData)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: SignState, updatedData: [String: Any]) {
        switch state {
        case .completed:
            Logger().debug("✅ Sign 입력 성공: \(updatedData)")
            temporaryData.merge(updatedData) { (_, new) in new }
            Logger().debug("✅ 병합된 temporaryData: \(temporaryData)")
            navigateToPCD()
        case .back:
            navigateBack()
        }
    }
    
    func navigateToPCD() {
        let PCDCoordinator = PetCardDoneCoordinator(/*navigationController: */navigationController, temporaryData: temporaryData)
        childCoordinators[PCDCoordinator.id] = PCDCoordinator
        PCDCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("SignCoordinator Deinit \(self)")
    }
}

extension SignCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
