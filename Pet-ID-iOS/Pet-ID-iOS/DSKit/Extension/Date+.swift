//
//  Date+.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/1/24.
//

import Foundation

extension DateFormatter {
    static let petInfoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")  // 한국 로케일 설정
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    static let localizedReservationDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        formatter.dateFormat = "MM월 dd일(E) HH:mm" // 원하는 형식
        return formatter
    }()
}
