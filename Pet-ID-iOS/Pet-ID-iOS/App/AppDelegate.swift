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

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    
    let logger: Logger = Logger()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        #if DEBUG
        Logger().debug("DEVELOP")
        #else
        Logger().debug("Product")
        #endif
        
        configureFirebase()
        configureOAuth()
        configurePushNotification(application: application)
        requestAccessibility()
        
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        
        return sceneConfig
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        return false
    }
}

// MARK: - ConfigureFirebase
extension AppDelegate {
    func configureFirebase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
#if DEBUG
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
#else
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
#endif
    }
}

// MARK: - ConfigureOAuth
extension AppDelegate {
    func configureOAuth() {
        KakaoSDK.initSDK(appKey: APIConfigs.Key.kakaoAppKey)
    }
}

// MARK: - FirebaseMessaging
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let fcmToken else { return }
        logger.debug("Firebase registration token: \(String(describing: fcmToken))")
        UserDefaultManager.shared.fcmToken = fcmToken
    }
}

// MARK: - ConfigurePushNotification
extension AppDelegate {
    
    func configurePushNotification(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOption,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
    }
}

// MARK: - UNUserNotificationCenterDelefate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

// MARK: - RequestAuthorization
extension AppDelegate {
    func requestAccessibility() {
        CameraAlbumManager.shared.requestAlbumAuthorization()
        CameraAlbumManager.shared.requestCameraAuthorization()
    }
}

