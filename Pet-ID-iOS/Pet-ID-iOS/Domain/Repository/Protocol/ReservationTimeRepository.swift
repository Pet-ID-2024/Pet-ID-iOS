//
//  ReservationTimeRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/7/24.
//

import Foundation

protocol ReservationTimeRepository {
    func availableTimes(hospitalId: Int, day: String, date: String) async throws -> [String]
}
