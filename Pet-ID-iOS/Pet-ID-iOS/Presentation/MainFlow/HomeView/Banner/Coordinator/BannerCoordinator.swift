//
//  BannerCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/20/24.
//

import SwiftUI
import Combine
import UIKit

final class BannerCoordinator: Coordinator, ObservableObject {
    
    var id: String = UUID().uuidString
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [String : any Coordinator] = [:]
    private var cancelBag = Set<AnyCancellable>()
    
    private let bannerFetcher: BannerFetcher
    
    init(_ navigationController: UINavigationController, bannerFetcher: BannerFetcher = DefaultBannerFetcher()) {
        self.navigationController = navigationController
        self.bannerFetcher = bannerFetcher
    }
    
    func start() {
        showBannerList()
    }
    
    private func showBannerList() {
        let viewModel = BannerViewModel(bannerFetcher: bannerFetcher, type: .main)
        let bannerView = BannerView(viewModel: viewModel)
        let bannerVC = BaseHostingViewController(rootView: bannerView)
        
        push(bannerVC, animate: true, isRoot: true)
        
        viewModel.result.subject
            .sink(receiveValue: { [weak self] state in
                self?.handleState(state)
            })
            .store(in: &cancelBag)
    }
    
    private func handleState(_ state: BannerState) {
        switch state {
        case .back:
            navigateBack()
        case .goToDetail(let banner):
            Logger().debug("➡️ Navigate to BlogDetailView for banner: \(banner.id)")
            navigateToBlogDetail(contentId: banner.id)
        }
    }
    
    private func navigateToBlogDetail(contentId: Int) {
        // Fetch the blog details if needed (optional step)
        Task {
            do {
                let blog = try await fetchBlogDetail(contentId: contentId)
                let blogCoordinator = PetBlogDetailCoordinator(navigationController, blog: blog)
                childCoordinators[blogCoordinator.id] = blogCoordinator
                blogCoordinator.start()
            } catch {
                Logger().error("❌ Failed to fetch blog detail: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchBlogDetail(contentId: Int) async throws -> Blog {
        let blogFetcher = DefaultBlogFetcher()
        return try await blogFetcher.detailBlog(contentId: contentId)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        Logger().debug("BannerCoordinator deinitialized: \(self)")
    }
}

extension BannerCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator)
    }
}
