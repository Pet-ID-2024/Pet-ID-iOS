//
//  HospitalFetcher.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

protocol HospitalFetcher {
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [Hospital]
}

struct DefaultHospitalFetcher: HospitalFetcher {
    private let repository: HospitalRepository
    
    init(repository: HospitalRepository = DefaultHospitalRepository()) {
        self.repository = repository
    }
    
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [Hospital] {
        Logger().debug("🟢 HospitalFetcher 호출 - sidoId: \(sidoId), sigunguId: \(sigunguId), eupmundongId: \(eupmundongId ?? -1)")
        
        do {
            let hospitals = try await repository.hospitals(sidoId: sidoId, sigunguId: sigunguId, eupmundongId: eupmundongId)
            Logger().debug("✅ HospitalFetcher 응답 완료 - 병원 데이터 수: \(hospitals.count)")
            return hospitals
        } catch {
            Logger().error("HospitalFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
}
