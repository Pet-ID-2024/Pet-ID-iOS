//
//  ReservationListFetcher.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/10/24.
//

import Foundation

protocol ReservationListFetcher {
    func createReservation(request: CreateReservationRequestDTO) async throws -> CreateReservation
    func updateReservation(request: UpdateReservationRequestDTO) async throws -> UpdateReservation
    func cancelReservation(orderId: Int) async throws -> CancelReservation
    func fetchReservations(status: ReservationStatus) async throws -> [ReservationList]
}

struct DefaultReservationListFetcher: ReservationListFetcher {
    
    private let repository: ReservationListRepository
    
    init(repository: ReservationListRepository = DefaultReservationListRepository()) {
        self.repository = repository
    }
    
    func createReservation(request: CreateReservationRequestDTO) async throws -> CreateReservation {
        Logger().debug("📡 ReservationListFetcher - createReservation 호출")
        do {
            let result = try await repository.createReservation(request: request)
            Logger().debug("✅ ReservationListFetcher - createReservation 성공: \(result)")
            return result
        } catch {
            Logger().error("❌ ReservationListFetcher - createReservation 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    func updateReservation(request: UpdateReservationRequestDTO) async throws -> UpdateReservation {
        Logger().debug("🟢 ReservationListFetcher - updateReservation 호출")
        do {
            let result = try await repository.updateReservation(request: request)
            Logger().debug("✅ ReservationListFetcher - updateReservation 성공: \(result)")
            return result
        } catch {
            Logger().error("❌ ReservationListFetcher - updateReservation 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    func cancelReservation(orderId: Int) async throws -> CancelReservation {
        Logger().debug("🟢 ReservationListFetcher - cancelReservation 호출")
        do {
            let result = try await repository.cancelReservation(orderId: orderId)
            Logger().debug("✅ ReservationListFetcher - cancelReservation 성공: \(result)")
            return result
        } catch {
            Logger().error("❌ ReservationListFetcher - cancelReservation 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchReservations(status: ReservationStatus) async throws -> [ReservationList] {
        Logger().debug("🟢 ReservationListFetcher - fetchReservations 호출, 상태: \(status.rawValue)")
        do {
            let result = try await repository.fetchReservations(status: status.rawValue)
            Logger().debug("✅ ReservationListFetcher - fetchReservations 성공: \(result.count)개의 데이터")
            return result
        } catch {
            Logger().error("❌ ReservationListFetcher - fetchReservations 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
