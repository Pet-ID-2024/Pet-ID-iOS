//
//  ReservationTime.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/7/24.
//

import Foundation

struct ReservationTime: Identifiable, Hashable {
    let id = UUID()
    let times: [String]
    
    init(times: [String]) {
        self.times = times
    }
}
