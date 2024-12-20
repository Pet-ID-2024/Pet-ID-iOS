//
//  PetBlogDetailCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/9/24.
//

import SwiftUI
import Combine
import UIKit


final class PetBlogDetailCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    private let blog: Blog
    
    let likeUpdatePublisher = ResultPublisher<(Int, Bool, Int)>()
    
    init(_ navigationController: UINavigationController, blog: Blog) {
        self.navigationController = navigationController
        self.blog = blog
    }
    
    func start() {
        showPetBlogDetail(for: blog)
    }
    
    private func showPetBlogDetail(for blog: Blog) {
        let viewModel = PetBlogDetailViewModel(blog: blog)
        let petBlogDatailView = PetBlogDetailView(viewModel: viewModel)
        let petBlogDetailVC = BaseHostingViewController(rootView: petBlogDatailView)
        
        // 여기서 push 메서드를 호출하여 뷰 컨트롤러를 네비게이션 스택에 추가합니다.
        push(petBlogDetailVC, animate: true/*, isRoot: true*/)  // 애니메이션을 적용하여 화면 전환
        
        // 좋아요 상태 변경 구독하여 외부로 전달
        viewModel.likeUpdatePublisher.subject
            .sink { [weak self] contentId, isLiked, likesCount in
                self?.likeUpdatePublisher.send((contentId, isLiked, likesCount))
            }
            .store(in: &cancelBag)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: PetBlogDetailState) {
        switch state {
        case .back:
            navigateBack()
        case .showDetail(let blog):
            showPetBlogDetail(for: blog)
        }
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("UserInfoCoordinator Deinit \(self)")
    }
}

extension PetBlogDetailCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
