//
//  ReservationTimeDataSource.swift
//  Pet-ID-iOS
//

import Foundation

protocol ReservationTimeDataSource {
    func availableTimes(hospitalId: Int, day: String, date: String) async throws -> [String]
}

struct DefaultReservationTimeDataSource: ReservationTimeDataSource {
    private let provider = Provider<ReservationTimeAPI>()
    
    func availableTimes(hospitalId: Int, day: String, date: String) async throws -> [String] {
//        Logger().debug("📡 ReservationTimeDataSource 요청 시작 - hospitalId: \(hospitalId), day: \(day), date: \(date)")
        
        let response: [String] = try await provider.request(.availableTimes(hospitalId: hospitalId, day: day, date: date))
        
        let times = response
        
//        Logger().debug("✅ 응답 완료 - 예약 가능 시간 데이터 조회: \(times)")
        return times
    }
}
