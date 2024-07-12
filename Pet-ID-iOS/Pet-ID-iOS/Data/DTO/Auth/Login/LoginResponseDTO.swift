//
//  LoginResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

struct LoginResponseDTO: Codable {
    var accessToken: String
    var refreshToken: String
    
    func toDomain() -> Authorization {
        return Authorization(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
