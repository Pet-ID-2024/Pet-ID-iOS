//
//  PetInfoRequestDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/31/24.
//

import Foundation

struct PetInfoRequestDTO {
    let name: String
    let birthDate: String
    let gender: String
    let neuteringDate: String?
    let neutered: String?
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "name": name,
            "birthDate" : birthDate,
            "gender": gender,
        ]
        
        if let neuteringDate = neuteringDate {
            dict["neuteringDate"] = neuteringDate
        }
        
        if let neutered = neutered {
            dict["neutered"] = neutered
        }
        
        return dict
    }
}
