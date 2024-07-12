//
//  UserDefaultManager.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Foundation

final class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private init() {}
    
    var userDefault: UserDefaults {
        return UserDefaults.standard
    }
    
    private enum Keys: String {
        case isFirstExecute
        case fcmToken
    }
    
    /// 앱을 처음 실행한건지
    var isFirstExecute: Bool {
        get {
            !userDefault.bool(forKey: Keys.isFirstExecute.rawValue)
        }
        set {
            userDefault.setValue(!newValue, forKey: Keys.isFirstExecute.rawValue)
        }
    }
    
    @UserDefault(key: Keys.fcmToken.rawValue, defaultValue: "")
    var fcmToken: String
}
