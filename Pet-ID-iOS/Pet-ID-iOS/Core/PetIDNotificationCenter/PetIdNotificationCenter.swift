//
//  PetIdNotificationCenter.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation

struct PetIdNotificationCenter {
    // PetIdNotificationCenter의 싱글톤 인스턴스
    static let shared = PetIdNotificationCenter()
    
    // 초기화를 외부에서 못하게 private로 설정
    private init () {}
    
    // 로그아웃 이벤트를 발행하는 ResultPublisher
    // 다른 클래스에서 이 객체를 구독해 로그아웃 이벤트를 처리할 수 O
    let logout = ResultPublisher<Void>()
}
