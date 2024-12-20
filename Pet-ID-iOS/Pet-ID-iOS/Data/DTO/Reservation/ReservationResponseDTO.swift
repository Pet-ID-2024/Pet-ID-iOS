//
//  ReservationResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/6/24.
//

import Foundation

// 예약 생성 응답 DTO
struct CreateReservationResponseDTO: Decodable {
    let id: Int
    let hospitalId: Int
    let date: Double
    
    func toDomain() -> CreateReservation {
        let parsedDate = Date(timeIntervalSince1970: date) // Unix Timestamp를 Date로 변환
//        Logger().debug("📥 서버 응답 데이터 확인 - id: \(id), hospitalId: \(hospitalId), date(UTC): \(parsedDate)")
        
        return CreateReservation(id: id, hospitalId: hospitalId, date: parsedDate)
    }
}


// 예약 수정 응답 DTO
struct UpdateReservationResponseDTO: Decodable {
    let id: Int
    let hospitalId: Int
    let date: String
    
    func toDomain() -> UpdateReservation {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return UpdateReservation(
            id: self.id,
            hospitalId: self.hospitalId,
            date: dateFormatter.date(from: self.date) ?? Date()
        )
    }
}

// 예약 취소 응답 DTO
struct CancelReservationResponseDTO: Decodable {
    let id: Int
    
    func toDomain() -> CancelReservation {
        return CancelReservation(id: self.id)
    }
}

// 예약 목록 조회 응답 DTO
struct ReservationListResponseDTO: Decodable {
    let id: Int
    let hospitalName: String
    let date: Double // Unix timestamp 형식
    let status: String
    
    func toDomain() -> ReservationList {
//        Logger().debug("📥 서버 응답 데이터 확인 - id: \(id), hospitalName: \(hospitalName), date(timestamp): \(date), status: \(status)")
        
        let parsedDate = Date(timeIntervalSince1970: date)
//        Logger().debug("📅 변환된 Date 확인 - date(UTC): \(parsedDate), formattedDate: \(DateFormatter.localizedReservationDate.string(from: parsedDate))")
        
        return ReservationList(
            id: self.id,
            hospitalName: self.hospitalName,
            date: parsedDate,
            status: ReservationStatus(rawValue: self.status) ?? .unknown
        )
    }
}
