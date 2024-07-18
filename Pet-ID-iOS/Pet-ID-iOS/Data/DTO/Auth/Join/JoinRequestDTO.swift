//
//  LoginRequestDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

struct JoinRequestDTO: Encodable {
    let token: String
    let fcmToken: String
    let ad: Bool
}
