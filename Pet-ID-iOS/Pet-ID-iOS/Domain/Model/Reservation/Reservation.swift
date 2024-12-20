//
//  Reservation.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/6/24.
//

import Foundation
import SwiftUI

struct CreateReservation {
    let id: Int
    let hospitalId: Int
    let date: Date
}

struct UpdateReservation {
    let id: Int
    let hospitalId: Int
    let date: Date
}

struct CancelReservation {
    let id: Int
}

struct ReservationList {
    let id: Int
    let hospitalName: String
    let date: Date
    let status: ReservationStatus
    
    var formattedDate: String {
        DateFormatter.localizedReservationDate.string(from: date)
    }
}

enum ReservationStatus: String {
    case all = "ALL"
    case pending = "PENDING"
    case confirmed = "CONFIRMED"
    case cancelled = "CANCELLED"
    case completed = "COMPLETED"
    case unknown = "UNKNOWN"
    
    var localized: String {
        switch self {
        case .all:
            return "전체"
        case .pending:
            return "예약대기"
        case .confirmed:
            return "예약확정"
        case .cancelled:
            return "예약취소"
        case .completed:
            return "방문완료"
        case .unknown:
            return "알 수 없음"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .cancelled, .completed:
            return .petid_f2
        default:
            return .petid_button
        }
    }
    
    // 상태에 따른 글자색
    var foregroundColor: Color {
        switch self {
        case .cancelled,.completed:
            return .petid_subtitle
        default:
            return .petid_clearblue
        }
    }
}
