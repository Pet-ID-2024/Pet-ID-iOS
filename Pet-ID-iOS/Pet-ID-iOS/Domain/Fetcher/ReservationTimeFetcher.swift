//
//  ReservationTimeFetcher.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

protocol ReservationTimeFetcher {
    func availableTimes(hospitalId: Int, day: String, date: String) async throws -> [String]
}

struct DefaultReservationTimeFetcher: ReservationTimeFetcher {
    private let repository: ReservationTimeRepository
    
    init(repository: ReservationTimeRepository = DefaultReservationTimeRepository()) {
        self.repository = repository
    }
    
    func availableTimes(hospitalId: Int, day: String, date: String) async throws -> [String] {
//        Logger().debug("🟢 ReservationTimeFetcher 호출 - hospitalId: \(hospitalId), day: \(day), date: \(date)")
        
        do {
            let times = try await repository.availableTimes(hospitalId: hospitalId, day: day, date: date)
//            Logger().debug("✅ ReservationTimeFetcher 응답 완료 - 예약 가능 시간 수: \(times.count)")
            return times
        } catch {
            Logger().error("ReservationTimeFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
}
