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
        return formatter
    }()
}
