//
//  LocationResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation

struct LocationResponseDTO: Decodable {
    let id: Int
    let name: String
    
    func toDomain() -> Location {
        return Location(
            id: self.id,
            name: self.name
        )
    }
}
