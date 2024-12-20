//
//  HolidayDataSource.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/8/24.
//

import Foundation

protocol HolidayDataSource {
    func checkHoliday(holidayId: Int, day: String) async throws -> Bool
}

struct DefaultHolidayDataSource: HolidayDataSource {
    private let provider = Provider<HolidayAPI>()
    
    func checkHoliday(holidayId: Int, day: String) async throws -> Bool {
//        Logger().debug("📡 HolidayDataSource 요청 시작 - hospitalId: \(holidayId), day: \(day)")
        
        let response: Bool = try await provider.request(.checkHoliday(holidayId: holidayId, day: day))
        
        let holiday = response
        
//        Logger().debug("✅ 응답 완료 - 휴일 데이터 조회: \(holiday)")
        
        return holiday
    }
}
