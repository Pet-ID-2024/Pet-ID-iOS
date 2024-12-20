//
//  DefaultReservationListRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/10/24.
//

import Foundation

struct DefaultReservationListRepository: ReservationListRepository {
    
    let dataSource: ReservationListDataSource
    
    init(dataSource: ReservationListDataSource = DefaultReservationListDataSource()) {
        self.dataSource = dataSource
    }
    
    func createReservation(request: CreateReservationRequestDTO) async throws -> CreateReservation {
        Logger().debug("📡 ReservationListRepository - createReservation 호출")
        let response = try await dataSource.createReservation(request: request)
        Logger().debug("✅ ReservationListRepository - createReservation 성공: \(response)")
        return response.toDomain()
    }
    
    func updateReservation(request: UpdateReservationRequestDTO) async throws -> UpdateReservation {
        Logger().debug("📡 updateReservationRepository - updateReservation 호출")
        let response = try await dataSource.updateReservation(request: request)
        Logger().debug("✅ updateReservationRepository - updateReservation 성공: \(response)")
        return response.toDomain()
    }
    
    func cancelReservation(orderId: Int) async throws -> CancelReservation {
        Logger().debug("📡 cancelReservationRepository - cancelReservation 호출")
        let response = try await dataSource.cancelReservation(orderId: orderId)
        Logger().debug("✅ cancelReservationRepository - cancelReservation 성공: \(response)")
        return response.toDomain()
    }
    
    func fetchReservations(status: String) async throws -> [ReservationList] {
        Logger().debug("📡 fetchReservationsRepository - fetchReservations 호출")
        let response = try await dataSource.fetchReservations(status: status)
        Logger().debug("✅ fetchReservationsRepository - fetchReservations 성공: \(response)")
        return response.map { $0.toDomain() }
    }
    
    
}
