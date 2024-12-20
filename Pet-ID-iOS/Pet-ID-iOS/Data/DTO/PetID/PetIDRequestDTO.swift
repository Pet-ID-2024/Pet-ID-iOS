//
//  PetIDRequestDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/20/24.
//

import Foundation

struct PetIDRequestDTO: Encodable {
    let petAddr: String
//    let petAddrDetails: String
    let chipType: String
    let petInfo: PetInfoRequestDTO
    let appearance: AppearanceRequestDTO
    let petImages: [PetImageRequestDTO]
    let proposer: ProposerRequestDTO
    let sign: String
}

struct PetInfoRequestDTO: Encodable {
    let petName: String
    let petBirthDate: String
    let petSex: String
    let petNeuteredYn: String
    let petNeuteredDate: String? // petNeuteredYn == "N"이면 null
}

struct AppearanceRequestDTO: Encodable {
    let breed: String
    let hairColor: String
    let weight: Int
    let hairLength: String
}

struct PetImageRequestDTO: Encodable {
    let imagePath: String
}

struct ProposerRequestDTO: Encodable {
    let name: String
    let address: String
    let addressDetails: String
//    let rra: String
//    let rraDetails: String
    let phone: String
}

