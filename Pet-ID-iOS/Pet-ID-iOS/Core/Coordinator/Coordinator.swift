//
//  Coordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/23/24.
//

import Foundation
import UIKit

@MainActor
public protocol Coordinator: AnyObject, Identifiable {
    var id: String { get }
    var finishDelegate: CoordinatorFinishDelegate? { get set } // 작업 완료 시 알리기 위한 델리게이터
    var navigationController: UINavigationController { get set } // 뷰 컨트롤러를 관리하는 네비게이션 컨트롤러
    var childCoordinators: [String: any Coordinator] { get set } // 자식 코디네이터를 저장하는 딕셔너리
    
    func start() // 코디네이터 흐름 시작
    func finish() // 작업을 완료하고 정리
    func add(coordinator: any Coordinator) // 자식 코디네이터 추가
    func free(coordinator: any Coordinator) // 자식 코디네이터 제거
}

public extension Coordinator {
    
    func add(coordinator: any Coordinator) {
        childCoordinators[coordinator.id] = coordinator // 자식 코디네이터 추가
    }
    
    func free(coordinator: any Coordinator) {
        childCoordinators[coordinator.id] = nil // 자식 코디네이터 제거
    }
    
    func finish() {
        childCoordinators.removeAll() // 모든 자식 코디네이터 제거
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self) // 델리게이트에 완료 알림
        
        Logger().debug("remove after child coordinators : \(self)") // 로그로 제거된 코디네이터 표시
    }
    
    // MARK: - push, pop
    
    func push(_ viewController: UIViewController, animate: Bool = true, isRoot: Bool = false) {
        if isRoot {
            navigationController.viewControllers = [viewController] // 루트 뷰 컨트롤러로 설정
        } else {
            navigationController.pushViewController(viewController, animated: animate) // 뷰 컨트롤러를 스택에 푸시
        }
    }
    
    func pop(animated: Bool) {
        if navigationController.viewControllers.count == 1 {
            navigationController.viewControllers = [] // 스택이 1개인 경우 비우기
        } else {
            navigationController.popViewController(animated: animated) // 최상위 뷰 컨트롤러 팝
        }
    }
    
    // MARK: - navigationBar

    func navigationBarHidden() {
        navigationController.setNavigationBarHidden(true, animated: false) // 네비게이션 바 숨기기
    }
}



