//
//  HolidayFetcher.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

protocol HolidayFetcher {
    func checkHoliday(holidayId: Int, day: String) async throws -> Bool
}

struct DefaultHolidayFetcher: HolidayFetcher {
    private let repository: HolidayRepository
    
    init(repository: HolidayRepository = DefaultHolidayRepository()) {
        self.repository = repository
    }
    
    func checkHoliday(holidayId: Int, day: String) async throws -> Bool {
//        Logger().debug("🟢 HolidayFetcher 호출 - holidayId: \(holidayId), day: \(day)")
        
        do {
            let isHoliday = try await repository.isHoliday(holidayId: holidayId, day: day)
//            Logger().debug("✅ HolidayFetcher 응답 완료 - 휴무 여부: \(isHoliday ? "휴무일" : "운영일")")
            return isHoliday
        } catch {
            Logger().error("HolidayFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
}
