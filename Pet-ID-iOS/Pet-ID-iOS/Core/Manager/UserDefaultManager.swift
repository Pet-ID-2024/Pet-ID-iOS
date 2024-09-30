//
//  UserDefaultManager.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Foundation

// UserDefaults를 관리하는 인스턴스 클래스
final class UserDefaultManager {
    
    // 공유 인스턴스
    static let shared = UserDefaultManager()
    
    private init() {}
    
    // UserDefaults의 기본 인스턴스
    var userDefault: UserDefaults {
        return UserDefaults.standard
    }
    
    // UserDefaults에서 사용할 키의 정의
    private enum Keys: String {
        case isFirstExecute // 앱 첫 실행 여부
        case fcmToken // Firebase Cloud Messaging 토큰
    }
    
    /// 앱을 처음 실행한건지
    var isFirstExecute: Bool {
        get {
            // 기본값이 false면 앱이 처음 실행된 것으로 간주
            !userDefault.bool(forKey: Keys.isFirstExecute.rawValue)
        }
        set {
            // 값 설정 시 반전해 저장
            userDefault.setValue(!newValue, forKey: Keys.isFirstExecute.rawValue)
        }
    }
    
    // FCM 토큰을 UserDefaults에 저장 및 가져오는 프로퍼티
    @UserDefault(key: Keys.fcmToken.rawValue, defaultValue: "")
    var fcmToken: String
}
