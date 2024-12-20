//
//  PetIDResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/20/24.
//

import Foundation

// 서버 응답 데이터를 담을 DTO
struct PetIDResponseDTO: Decodable {
    let petId: Int
    let ownerId: Int
    let petRegNo: String
    let petAddr: String
    let petInfo: PetInfoResponseDTO
    let appearance: AppearanceResponseDTO
    let petImages: [PetImageResponseDTO]
    
    func toDomain() -> PetDetails {
        return PetDetails(petId: self.petId, ownerId: self.ownerId, petRegNo: self.petRegNo, petAddr: self.petAddr, appearance: self.appearance.toDomain(), petImages: self.petImages.map { $0.toDomain() }
            
        )
    }
}

struct PetInfoResponseDTO: Decodable {
    let petName: String
    let petBirthDate: String
    let petSex: String
    let petNeuteredYn: String
    let petNeuteredDate: String
    
    func toDomain() -> PetInfoDetails {
        return PetInfoDetails(petName: self.petName, petBirthDate: self.petBirthDate, petSex: self.petSex, petNeuteredYn: self.petNeuteredYn, petNeuteredDate: self.petNeuteredDate)
    }
}

// Appearance 데이터
struct AppearanceResponseDTO: Decodable {
    let appearanceId: Int
    let breed: String
    let hairColor: String
    let weight: Int
    let hairLength: String
    
    func toDomain() -> Appearance {
        return Appearance(
            appearanceId: self.appearanceId,
            breed: self.breed,
            hairColor: self.hairColor,
            weight: self.weight,
            hairLength: self.hairLength
        )
    }
}

// Pet 이미지 데이터
struct PetImageResponseDTO: Decodable {
    let petImageId: Int
    let petId: Int
    let imagePath: String
    
    func toDomain() -> PetImage {
        return PetImage(
            petImageId: self.petImageId,
            petId: self.petId,
            imagePath: self.imagePath
        )
    }
}

