//
//  JoinResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

struct JoinResponseDTO: Decodable {
    var accessToken: String
    var refreshToken: String
    
    func toDomain() -> Authorization {
        return Authorization(
            accessToken: self.accessToken,
            refreshToken: self.refreshToken
        )
    }
}
