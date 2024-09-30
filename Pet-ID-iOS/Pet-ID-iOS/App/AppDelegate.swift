//
//  AppDelegate.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/28/24.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
import FirebaseAnalytics
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin
import GoogleSignIn

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    
    // Logger 객체 선언(앱 실행 중 로그 기록)
    let logger: Logger = Logger()
    
    // 앱이 시작될 떄 호출되는 메서드
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        #if DEBUG
        Logger().debug("DEVELOP")
        #else
        Logger().debug("Product")
        #endif
        
        configureFirebase() // firebase 설정
        configureOAuth() // OAuth 설정(카카오, 네이버, 구글)
        configurePushNotification(application: application) // 푸시 알림 설정
        requestAccessibility() // 카메라 및 앨범 접근 권한 요청
        
        
        
        return true
    }
    
    // 새로운 scene 연결 시 설정(멀티 윈도우 지원)
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self // SceneDelegate 설정
        
        return sceneConfig
    }
    
    // 외부 앱을 통해 앱이 열릴 떄 호출되는 메서드(OAuth 인증 시 사용)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url) // 카카오 로그인 처리
        }
        
        return GIDSignIn.sharedInstance.handle(url) // 구글 로그인 처리
        
        return false
    }
}

// MARK: - ConfigureFirebase
extension AppDelegate {
    // Firebase 초기 설정 메서드
    func configureFirebase() {
        FirebaseApp.configure() // Firebase 설정
        Messaging.messaging().delegate = self // FirebaseMessaging 델리게이트 설정
        
#if DEBUG
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
#else
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
#endif
    }
}

// MARK: - ConfigureOAuth
extension AppDelegate {
    // OAuth 설정(카카오, 네이버)
    func configureOAuth() {
        KakaoSDK.initSDK(appKey: APIConfigs.Key.kakaoAppKey) // 카카오 SDK 초기화
        configureOAuthNaver() // 네이버 OAuth 설정
    }
    
    // 네이버 OAuth 설정 메서드
    private func configureOAuthNaver() {
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        // 네이버 앱으로 인증하는 방식 활성화
        instance?.isNaverAppOauthEnable = true
        // Safari에서 인증하는 방식 활성화
        instance?.isInAppOauthEnable = true
        // 인증 화면을 iPhone의 세로 모드에서만 사용하기
        instance?.isOnlyPortraitSupportedInIphone()
        
        // 네이버 아이디로 로그인하기 설정
        // 앱 등록시 입력한 URL Scheme
        instance?.serviceUrlScheme = APIConfigs.Key.urlScheme
        // 앱 등록후 발급받은 클라이언트 아이디
        instance?.consumerKey = APIConfigs.Key.naverClientID
        // 앱 등록 후 발급받은 클라이언트 시크릿
        instance?.consumerSecret = APIConfigs.Key.naverClientSecret
        // 앱 이름
        instance?.appName = Configs.appName
    }
}

// MARK: - FirebaseMessaging
extension AppDelegate: MessagingDelegate {
    // FCM 토큰을 수신했을 때 호출되는 메서드
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let fcmToken else { return }
        logger.debug("Firebase registration token: \(String(describing: fcmToken))")
        UserDefaultManager.shared.fcmToken = fcmToken // FCM 토큰 저장
    }
}

// MARK: - ConfigurePushNotification
extension AppDelegate {
    // 푸시 알림 설정 메서드
    func configurePushNotification(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self // 알림 센터 델리게이트 설정
        
        // 알림 권한 요청(알림, 뱃지, 사운드)
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOption,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications() // 원격 알림 등록
    }
}

// MARK: - UNUserNotificationCenterDelefate
extension AppDelegate: UNUserNotificationCenterDelegate {
    // 앱이 실행 중일 때 푸시 알림을 받을 때 호출되는 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner]) // 푸시 알림 리스트 및 배너 형식으로 표시
    }
    
    // 원격 알림 등록 성공 시 APNs 토큰을 수신
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken // APNs 토큰 설정
    }
}

// MARK: - RequestAuthorization
extension AppDelegate {
    // 접근 권한 요청 메서드(카메라, 앨범)
    func requestAccessibility() {
        CameraAlbumManager.shared.requestAlbumAuthorization() // 앨범 접근 권한 요청
        CameraAlbumManager.shared.requestCameraAuthorization() // 카메라 접근 권한 요청
    }
}

