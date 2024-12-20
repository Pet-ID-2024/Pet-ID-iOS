//
//  PetBlogMainCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/9/24.
//

//
//  PetBlogMainCoordinator.swift
//  Pet-ID-iOS
//

import Foundation
import Combine
import SwiftUI

final class PetBlogMainCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String: any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showPetBlog()
    }
    
    private func showPetBlog() {
        let viewModel = PetBlogMainViewModel()
        let petBlogVC = BaseHostingViewController(rootView: PetBlogMainView(viewModel: viewModel))
        push(petBlogVC, animate: false, isRoot: false)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleStateSelection(state, viewModel: viewModel)
            })
            .store(in: &cancelBag)
    }
    
    private func handleStateSelection(_ state: PetBlogState, viewModel: PetBlogMainViewModel) {
        switch state {
        case .detail(let blog):
            navigateToDetail(blog: blog, viewModel: viewModel)
        case .back:
            navigateBack()
        }
    }
    
    func navigateToDetail(blog: Blog, viewModel: PetBlogMainViewModel) {
        Task {
            do {
                // 최신 블로그 상세 데이터 가져오기
                let detailBlog = try await viewModel.blogFetcher.detailBlog(contentId: blog.contentId)
                
                // 상세 데이터 기반으로 코디네이터 초기화 및 화면 이동
                let detailCoordinator = PetBlogDetailCoordinator(navigationController, blog: detailBlog)
                
                // 좋아요 수 업데이트를 구독하여 MainViewModel에 반영
                detailCoordinator.likeUpdatePublisher.subject
                    .sink { [weak viewModel] contentId, _, likesCount in
                        viewModel?.updateLikesCount(for: contentId, likesCount: likesCount)
                    }
                    .store(in: &cancelBag)
                
                childCoordinators[detailCoordinator.id] = detailCoordinator
                detailCoordinator.start()
            } catch {
                print("Error: 블로그 상세 정보 로드 실패 - \(error.localizedDescription)")
            }
        }
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}

extension PetBlogMainCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
