//
//  HolidayRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/8/24.
//

import Foundation

protocol HolidayRepository {
    func isHoliday(holidayId: Int, day: String) async throws -> Bool
}
