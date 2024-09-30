//
//  AppCoordinator.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import SwiftUI
import Combine

// AppChildCoordinator: 앱의 하위 코디네이터 상태 정의
public enum AppChildCoordinator: Hashable {
    case splash
    case login
    case main
}

// 앱 전체의 흐름을 관리하는 메인 코디네이터
public final class AppCoordinator: Coordinator {
    
    public let id: String = UUID().uuidString
    // 코디네이터 완료 시 호출될 델리게이트
    public var finishDelegate: CoordinatorFinishDelegate?
    // 네비게이션 컨트롤러(화면 전환 관리)
    public var navigationController: UINavigationController
    // 하위 코디네이터 저장하는 딕셔너리
    public var childCoordinators: [String : any Coordinator]
    // 윈도우 객체(UI 창 관리)
    let window: UIWindow?
    // Combine cancelBag, 구독 해제를 위해 사용
    private var cancelBag = Set<AnyCancellable>()
    // 초기화 메서드: 윈도우 객체를 받아 네비게이션 컨트롤러 및 코디네이터 초기화 후 start 메서드 호출
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        self.childCoordinators = [:]
        
        start() // 앱 시작 시 초기 흐름 설정
    }
    
    // 앱의 흐름 시작(스플래시 화면 표시, 로그아웃 상태 바인딩)
    public func start() {
        setup(with: window) // 윈도우 및 네비게이션 설정
        runSplashFlow() // 스플래시 플로우 실행
        bindLogout() // 로그아웃 이벤트 바인딩
    }
    
    // 윈도우 및 네비게이션 설정 메서드
    private func setup(with window: UIWindow?) {
        window?.rootViewController = navigationController // 루트 뷰 컨트롤러 설정
        window?.makeKeyAndVisible() // 윈도우를 보이게 설정
        window?.backgroundColor = .white // 배경색 설정
    }
    
    // 스플래시 화면 플로우 실행
    private func runSplashFlow() {
        let coordinator = SplashCoordinator(navigationController: navigationController) // 스플래시 코디네이터 생성
        add(coordinator: coordinator) // 코디네이터 추가
        coordinator.finishDelegate = self // 완료 델리게이트 설정
        coordinator.splashFinishDelegate = self // 스플래시 완료 델리게이트 설정
        coordinator.start() // 스플래시 코디네이터 시작
    }
    
    // 로그인 화면 플로우 실행
    private func runLoginFlow() {
        let coordinator = LoginCoordinator(navigationController: navigationController) // 로그인 코디네이터 설정
        add(coordinator: coordinator)
        coordinator.finishDelegate = self
        coordinator.loginFinishDelegate = self
        coordinator.start()
    }
    
    // 메인 탭 화면 플로우 실행
    private func runTabFlow() {
        let coordinator = TabCoordinator(navigationController)
        add(coordinator: coordinator)
        coordinator.finishDelegate = self
        coordinator.tabFinishDelegate = self
        coordinator.start()
    }
    
    // 로그아웃 이벤트 바인딩
    private func bindLogout() {
        PetIdNotificationCenter.shared.logout.subject // 로그아웃 노티피케이션 구독
            .sink(receiveValue: { [weak self] _ in
                // 로그아웃 시 네비게이션 초기화 및 로그인 플로우 실행
                guard let self else { return }
                navigationController = UINavigationController()
                childCoordinators = [:]
                setup(with: self.window)
                runLoginFlow()
            })
            .store(in: &cancelBag)
    }
}

// MARK: - SplashFinishDelegate
// 스플래시 코디네이터 완료 델리게이트 구현
extension AppCoordinator: SplashFinishDelegate {
    func finish(result: SplashCoordinatorResult) {
        switch result {
        case .login:
            runLoginFlow() // 스플래시 후 로그인 플로우 실행
        case .tab:
            runTabFlow() // 스플래시 후 메인 탭 플로우 실행
        }
    }
}

// MARK: - LoginFinishDelegate
// 로그인 코디네이터 완료 델리게이트 구현
extension AppCoordinator: LoginFinishDelegate {
    func finish(result: LoginCoordinatorResult) {
        switch result {
        case .tab:
            runTabFlow() // 로그인 후 메인 탭 플로우 실행
        }
    }
}

// MARK: - CoordinatorFinishDelegate
// 하위 코디네이터가 완료되었을 때 호출되는 델리게이트 구현
extension AppCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.free(coordinator: childCoordinator) // 하위 코디네이터 해제
    }
}

// MARK: - TabFinishDelegate
// 탭 코디네이터 완료 델리게이트 구현
extension AppCoordinator: TabFinishDelegate {
    
}

