//
//  LoginRequestDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

public struct LoginRequestDTO: Encodable {
    public var sub: String
    public var fcmToken: String
}
