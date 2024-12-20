//
//  DefaultHolidayRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

struct DefaultHolidayRepository: HolidayRepository {
    let dataSource: HolidayDataSource
    
    init(dataSource: HolidayDataSource = DefaultHolidayDataSource()) {
        self.dataSource = dataSource
    }
    
    func isHoliday(holidayId: Int, day: String) async throws -> Bool {
        do {
//            Logger().debug("📡 HolidayRepository 요청 시작 - hospitalId: \(holidayId), day: \(day)")
            let isHoliday = try await dataSource.checkHoliday(holidayId: holidayId, day: day)
//            Logger().debug("✅ HolidayRepository 응답 완료 - 병원 휴무일 여부: \(isHoliday ? "휴무일" : "운영일")")
            return isHoliday
        } catch {
            Logger().error("❌ HolidayRepository 오류 발생: hospitalId: \(holidayId), day: \(day): \(error.localizedDescription)")
            throw error
        }
    }
}
