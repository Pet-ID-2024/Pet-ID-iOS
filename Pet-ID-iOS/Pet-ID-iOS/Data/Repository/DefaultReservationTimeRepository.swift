//
//  DefaultReservationTimeRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

struct DefaultReservationTimeRepository: ReservationTimeRepository {
    let dataSource: ReservationTimeDataSource
    
    init(dataSource: ReservationTimeDataSource = DefaultReservationTimeDataSource()) {
        self.dataSource = dataSource
    }
    
    func availableTimes(hospitalId: Int, day: String, date: String) async throws -> [String] {
        do {
//            Logger().debug("📡 Repository 요청 시작 - hospitalId: \(hospitalId), day: \(day), date: \(date)")
            let times = try await dataSource.availableTimes(hospitalId: hospitalId, day: day, date: date)
//            Logger().debug("✅ Repository 응답 완료 - 예약 가능 시간 데이터 조회: \(times)")
            return times
        } catch {
            Logger().error("❌ Repository 오류 발생: hospitalId: \(hospitalId), day: \(day), date: \(date): \(error.localizedDescription)")
            throw error
        }
    }
}
