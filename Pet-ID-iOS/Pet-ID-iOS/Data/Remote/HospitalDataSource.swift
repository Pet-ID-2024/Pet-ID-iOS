//
//  HospitalDataSource.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

protocol HospitalDataSource {
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [HospitalResponseDTO]
}

struct DefaultHospitalDataSource: HospitalDataSource {
    private let provider = Provider<HospitalAPI>()
    
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [HospitalResponseDTO] {
        Logger().debug("📡 HospitalDataSource 요청 시작 - sidoId: \(sidoId), sigunguId: \(sigunguId), eupmundongId: \(eupmundongId ?? -1)")
        let response: [HospitalResponseDTO] = try await provider.request(.hospitals(sido: sidoId, sigunguId: sigunguId, eupmundong: eupmundongId))
        Logger().debug("✅ 응답 완료 - 병원 데이터 조회: \(response)")
        return response
    }
}
