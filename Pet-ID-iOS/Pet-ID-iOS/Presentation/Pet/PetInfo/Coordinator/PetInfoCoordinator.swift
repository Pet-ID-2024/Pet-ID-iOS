import SwiftUI
import Combine
import UIKit


final class PetInfoCoordinator: Coordinator, ObservableObject {
    
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
        showPetInfo()
    }
    
    private func showPetInfo() {
        let viewModel = PetInfoViewModel(temporaryData: temporaryData)
        let petInfoView = PetInfo(viewModel: viewModel)
        let PetInfoVC = BaseHostingViewController(rootView: petInfoView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(PetInfoVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state, updatedData: viewModel.temporaryData)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: PetInfoState, updatedData: [String: Any]) {
        switch state {
        case .back:
            navigateBack()
        case .valid:
            Logger().debug("✅ PetCaption 입력 성공: \(updatedData)")
            temporaryData.merge(updatedData) { (_, new) in new }
            showpetCaption()
        case .invalid:
            print("Input is invalid")
        }
    }
    
    func showpetCaption() {
        let petCaptionCoordinator = PetCaptionCoordinator(/*navigationController: */navigationController, temporaryData: temporaryData)
        childCoordinators[petCaptionCoordinator.id] = petCaptionCoordinator
        petCaptionCoordinator.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("PetInfoCoordinator Deinit \(self)")
    }
}

extension PetInfoCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
