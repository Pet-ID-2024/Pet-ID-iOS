//
//  Holiday.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/7/24.
//

import Foundation

struct Holiday: Identifiable, Hashable {
    let id = UUID()
    let isHoliday: Bool // true면 휴무, false면 운영
    
    init(isHoliday: Bool) {
        self.isHoliday = isHoliday
    }
}
