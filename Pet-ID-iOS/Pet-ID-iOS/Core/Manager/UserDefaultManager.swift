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
    }
    
    var isFirstExecute: Bool {
        get {
            !userDefault.bool(forKey: Keys.isFirstExecute.rawValue)
        }
        set {
            userDefault.setValue(false, forKey: Keys.isFirstExecute.rawValue)
        }
    }
}