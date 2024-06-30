//
//  Pet_ID_iOSApp.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/3/24.
//

import SwiftUI

@main
struct Pet_ID_iOSApp: App {

    @UIApplicationDelegateAdaptor var delegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
