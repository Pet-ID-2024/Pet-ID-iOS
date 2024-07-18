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
    
    let logout = ResultPublisher<Void>()
}
