//
//  PetID.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/20/24.
//

import Foundation

struct PetDetails {
    let petId: Int
    let ownerId: Int
    let petRegNo: String
    let petName: String
    let petBirthDate: String
    let petSex: String
    let petNeuteredYn: String
    let petNeuteredDate: String?
    let petAddr: String
    let appearance: Appearance
    let petImages: [PetImage]
}

struct Appearance {
    let appearanceId: Int
    let breed: String
    let hairColor: String
    let weight: Int
    let hairLength: String
}

struct PetImage {
    let petImageId: Int
    let petId: Int
    let imagePath: String
}

