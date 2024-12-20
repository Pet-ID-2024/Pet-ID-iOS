//
//  ReservationListDataSource.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/10/24.
//

import Foundation
import Moya

protocol ReservationListDataSource {
    func createReservation(request: CreateReservationRequestDTO) async throws -> CreateReservationResponseDTO
    func updateReservation(request: UpdateReservationRequestDTO) async throws -> UpdateReservationResponseDTO
    func cancelReservation(orderId: Int) async throws -> CancelReservationResponseDTO
    func fetchReservations(status: String) async throws -> [ReservationListResponseDTO]
}

struct DefaultReservationListDataSource: ReservationListDataSource {
    
    private let provider = Provider<ReservationListAPI>()
    
    // 예약 생성
    func createReservation(request: CreateReservationRequestDTO) async throws -> CreateReservationResponseDTO {
        Logger().debug("📡 ReservationListDataSource - createReservation 요청 시작: \(request.hospitalId), date: \(request.date)")
        
        do {
            let response: CreateReservationResponseDTO = try await provider.request(.createReservation(hospitalId: request.hospitalId, date: request.date))
            Logger().debug("✅ ReservationListDataSource - createReservation 응답 성공: \(response)")
            return response
        } catch {
            Logger().error("❌ ReservationListDataSource - createReservation 요청 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    // 예약 수정
    func updateReservation(request: UpdateReservationRequestDTO) async throws -> UpdateReservationResponseDTO {
        Logger().debug("📡 ReservationListDataSource - updateReservation 요청 시작: \(request.orderId)")
        
        do {
            let response: UpdateReservationResponseDTO = try await provider.request(.updateReservation(orderId: request.orderId, date: request.date))
            Logger().debug("✅ ReservationListDataSource - updateReservation 응답 성공: \(response)")
            return response
        } catch {
            Logger().error("❌ ReservationListDataSource - updateReservation 요청 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    // 예약 취소
    func cancelReservation(orderId: Int) async throws -> CancelReservationResponseDTO {
        Logger().debug("📡 ReservationListDataSource - cancelReservation 요청 시작: \(orderId)")
        
        do {
            let response: Int = try await provider.request(.cancelReservation(orderId: orderId))
            Logger().debug("✅ ReservationListDataSource - cancelReservation 응답 성공: \(response)")
            return CancelReservationResponseDTO(id: response)
        } catch {
            Logger().error("❌ ReservationListDataSource - cancelReservation 요청 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    // 예약 목록 조회
    func fetchReservations(status: String) async throws -> [ReservationListResponseDTO] {
        Logger().debug("📡 ReservationListDataSource - fetchReservations 요청 시작: \(status)")
        
        do {
            let response: [ReservationListResponseDTO] = try await provider.request(.fetchReservations(status: status))
            Logger().debug("✅ ReservationListDataSource - fetchReservations 응답 성공: \(response.count)개의 데이터")
            return response
        } catch {
            Logger().error("❌ ReservationListDataSource - fetchReservations 요청 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
