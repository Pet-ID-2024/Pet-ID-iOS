//
//  TabBarCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/7/24.
//

import Foundation
import UIKit

enum TabList: Int, CaseIterable {
    case home
    case hospital
    case blog
    case myPage
    
    var title: String {
        switch self {
        case .home: return "홈"
        case .hospital: return "등록대행병원"
        case .blog: return "펫블로그"
        case .myPage: return "my"
        }
    }
    
    var imageName: String {
        switch self {
        case .home: return "home"
        case .hospital: return "hospital"
        case .blog: return "blog"
        case .myPage: return "person"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .home: return "home_s"
        case .hospital: return "hospital_s"
        case .blog: return "blog_s"
        case .myPage: return "person_s"
        }
    }
        
}

public protocol TabFinishDelegate: AnyObject {
    
}

final class TabCoordinator: Coordinator {
    
    var id: String = UUID().uuidString
    weak var finishDelegate: CoordinatorFinishDelegate?
    weak var tabFinishDelegate: TabFinishDelegate?
    var navigationController: UINavigationController
    var tabBarController = UITabBarController()
    var childCoordinators: [String : any Coordinator] = [:]
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        push(tabBarController, animate: false, isRoot: true)
        setup()
    }
    
    private func setup() {
        var rootViewControllers: [UINavigationController] = []
        
        TabList.allCases.forEach {
            let navigationController = navigationController($0)
            navigationController.setNavigationBarHidden(true, animated: false)
            rootViewControllers.append(navigationController)
            
            switch $0 {
            case .home: showHome(navigationController)
            case .hospital: break
            case .blog: break
            case .myPage: break
            }
        }
        
        tabBarController.setViewControllers(rootViewControllers, animated: false)
        tabBarController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func showHome(_ root: UINavigationController) {
        let coordinator = HomeCoordinator(root)
        add(coordinator: coordinator)
        coordinator.finishDelegate = self
        coordinator.start()
    }
    
    private func navigationController(_ tabItem: TabList) -> UINavigationController {
        let navigationController = UINavigationController()
        let tabBarItem = UITabBarItem(
            title: tabItem.title,
            image: UIImage(named: tabItem.imageName),
            tag: tabItem.rawValue
        )
        
        tabBarItem.selectedImage = UIImage(named: tabItem.selectedImageName)
        navigationController.tabBarItem = tabBarItem
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }
}

extension TabCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        free(coordinator: childCoordinator)
    }
}
