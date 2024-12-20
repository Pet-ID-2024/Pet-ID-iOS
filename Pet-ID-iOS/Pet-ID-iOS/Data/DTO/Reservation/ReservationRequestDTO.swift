//
//  ReservationRequestDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/6/24.
//

import Foundation

struct CreateReservationRequestDTO: Encodable {
    let hospitalId: Int
    let date: String // ISO8601 Format

    init(hospitalId: Int, date: Date) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        self.date = dateFormatter.string(from: date)
        self.hospitalId = hospitalId
//        print("📤 요청 데이터 생성 - hospitalId: \(hospitalId), date(UTC): \(self.date)")
    }
}

struct UpdateReservationRequestDTO: Encodable {
    let orderId: Int
    let date: String
    
    init(orderId: Int, date: Date) {
        self.orderId = orderId
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        self.date = dateFormatter.string(from: date)
    }
}
