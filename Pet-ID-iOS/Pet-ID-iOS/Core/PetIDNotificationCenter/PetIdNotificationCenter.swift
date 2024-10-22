//
//  PetIdNotificationCenter.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation

struct PetIdNotificationCenter {
    
    static let shared = PetIdNotificationCenter()
    
    private init () {}
    
    // 로그아웃 이벤트 퍼블리셔
    let logout = ResultPublisher<Void>()
    let loginSuccess = ResultPublisher<Void>()
    let newNotification = ResultPublisher<String>()
}
