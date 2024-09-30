//
//  UserDefault.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    // UserDefaults에 저장할 키
    private let key: String
    // 기본값(UserDefault에 값이 없을 때 반환)
    private let defaultValue: T
    // 초기화 메서드, 키와 기본 값을 설정
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    // 프로퍼티에 접근할 때 UserDefault에서 값을 가져오고, 없으면 기본값을 반환
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        } set { // 값을 설정할 때 UserDefaults에 저장
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
