//
//  HolidayResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/8/24.
//

import Foundation

struct HolidayResponseDTO: Decodable {
    let isHoliday: Bool
    
    func toDomain() -> Holiday {
        return Holiday(
            isHoliday: self.isHoliday
        )
    }
}
