//
//  ReservationListRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/10/24.
//

import Foundation

protocol ReservationListRepository {
    func createReservation(request: CreateReservationRequestDTO) async throws -> CreateReservation
    func updateReservation(request: UpdateReservationRequestDTO) async throws -> UpdateReservation
    func cancelReservation(orderId: Int) async throws -> CancelReservation
    func fetchReservations(status: String) async throws -> [ReservationList]
}
