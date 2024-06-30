//
//  Pet_ID_iOSApp.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/3/24.
//

import SwiftUI

class AppFlowState: ObservableObject {
    enum Flow {
        case splash
        case main
        case login
    }
    
    @Published var currentFlow: Flow = .splash
}

@main
struct Pet_ID_iOSApp: App {

    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
    @StateObject var appFlowState = AppFlowState()

    var body: some Scene {
        WindowGroup {
            switch appFlowState.currentFlow {
            case .splash:
                SplashView()
                    .environmentObject(appFlowState)
            case .main:
                MainView()
                    .environmentObject(appFlowState)
            case .login:
                AccessibilityPermissionRequestView()
                    .environmentObject(appFlowState)
            }
        }
    }
}
