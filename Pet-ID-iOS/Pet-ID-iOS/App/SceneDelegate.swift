//
//  SceneDelegate.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/28/24.
//

import UIKit
import KakaoSDKAuth
import NaverThirdPartyLogin

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    // 앱의 메인 윈도우
    var window: UIWindow?
    // AppCoordinator 객체 (앱의 흐름 관리)
    var appCoordinator: AppCoordinator?
    
    // 앱의 화면이 연결될 때 호출되는 메서드
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // UIWindowScene을 설정하고 AppCoordinator를 초기화
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        appCoordinator = AppCoordinator(window: window)
        
        // AppCoordinator의 시작 호출 지점
        appCoordinator?.start()
    }
    
    // 앱이 백그라운드로 전환될 때 호출
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    // 앱이 활성화될 때 호출
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    // 앱이 비활성화될 때 호출
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    // 앱이 포어그라운드에 들어갈 때 호출
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    // 앱이 백그라운드로 들어갈 때 호출
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    // 앱이 URL을 통해 열릴 때 호출 (OAuth 인증 처리)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            } else {
                // 네이버 로그인 URL 처리
                NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .receiveAccessToken(URLContexts.first?.url)
            }
        }
    }
}
