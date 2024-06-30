//
//  AuthorizationDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

struct AuthorizationDTO: Codable{
    var accessToken: String
    var refreshToken: String
    
    func toDomain() -> Authorization {
        return .init(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
