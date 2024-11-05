//
//  AddressDataSource.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation

protocol AddressDataSource {
    func sido() async throws -> [LocationResponseDTO]
    func sigungu(sidoId: Int) async throws -> [LocationResponseDTO]
    func eupmundong(sigunguId: Int) async throws -> [LocationResponseDTO]
}

struct DefaultAddressDataSource: AddressDataSource {
    
    private let provider: Provider<AddressAPI> = Provider()
    
    func sido() async throws -> [LocationResponseDTO] {
        let url = "\(AddressAPI.sido.baseURL)\(AddressAPI.sido.path)"
//        Logger().debug("Request URL (sido): \(url)")
        
//        Logger().debug("📡 요청 시작 - 시도 데이터 조회")
        let response: [LocationResponseDTO] = try await provider.request(.sido)
//        Logger().debug("✅ 응답 완료 - 시도 데이터 조회: \(response)")
        return response
    }
    
    func sigungu(sidoId: Int) async throws -> [LocationResponseDTO] {
//        let url = "\(AddressAPI.sigungu(sidoId: sidoId).baseURL)\(AddressAPI.sigungu(sidoId: sidoId).path)"
//        Logger().debug("Request URL (sigungu): \(url)")
        
//        Logger().debug("📡 요청 시작 - 시군구 데이터 조회 (sidoId: \(sidoId))")
        let response: [LocationResponseDTO] = try await provider.request(.sigungu(sidoId: sidoId))
//        Logger().debug("✅ 응답 완료 - 시군구 데이터 조회: \(response)")
        return response
    }
    
    func eupmundong(sigunguId: Int) async throws -> [LocationResponseDTO] {
//        let url = "\(AddressAPI.eupmundong(sigunguId: sigunguId).baseURL)\(AddressAPI.eupmundong(sigunguId: sigunguId).path)"
//        Logger().debug("Request URL (eupmundong): \(url)")
        
//        Logger().debug("📡 요청 시작 - 읍면동 데이터 조회 (sigunguId: \(sigunguId))")
        let response: [LocationResponseDTO] = try await provider.request(.eupmundong(sigunguId: sigunguId))
//        Logger().debug("✅ 응답 완료 - 읍면동 데이터 조회: \(response)")
        return response
    }
}
