import Foundation
import Combine
import SwiftUI

final class OnboardingCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showOnboarding()
    }
    
    private func showOnboarding() {
        let viewModel = OnboardingViewModel()
        let onboardingVC = BaseHostingViewController(rootView: OnboardingView(viewModel: viewModel))
        push(onboardingVC, animate: false, isRoot: false)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: OnboardingState) {
        switch state {
        case .next:
            navigateToLogin()
        }
    }
    
    private func navigateToLogin() {
        let viewModel = LoginMainViewModel() // 로그인 화면 ViewModel 생성
        let loginVC = BaseHostingViewController(rootView: LoginMainView(viewModel: viewModel))
        push(loginVC, animate: true)
    }
    
    deinit {
        Logger().debug("OnboardingCoordinator Deinit \(self)")
    }
}

extension OnboardingCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
