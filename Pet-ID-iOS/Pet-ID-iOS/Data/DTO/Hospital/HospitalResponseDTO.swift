//
//  HospitalResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

struct HospitalResponseDTO: Decodable {
    let id: Int
    let imageUrl: String?
    let address: String
    let name: String
    let hours: String?
    let tel: String
    let vet: String
    
    func toDomain() -> Hospital {
        return Hospital(id: self.id, imageUrl: self.imageUrl, address: self.address, name: self.name, hours: self.hours, tel: self.tel, vet: self.vet)
    }
}
