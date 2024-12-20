//
//  ReservationTimeResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/7/24.
//

import Foundation

struct ReservationTimeResponseDTO: Decodable {
    let times: [String]
    
    func toDomain() -> ReservationTime {
        return ReservationTime(
            times: self.times
        )
    }
}
