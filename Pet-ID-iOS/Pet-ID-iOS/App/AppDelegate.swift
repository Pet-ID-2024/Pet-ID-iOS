//
//  AppDelegate.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/28/24.
//

import UIKit

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        #if DEBUG
        Logger().debug("DEVELOP")
        #else
        Logger().debug("Product")
        #endif
        registerDependencies()
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
    
    
}

