//
//  DefaultHospitalRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

struct DefaultHospitalRepository: HospitalRepository {
    let dataSource: HospitalDataSource
    
    init(dataSource: HospitalDataSource = DefaultHospitalDataSource()) {
        self.dataSource = dataSource
    }
    
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [Hospital] {
        do {
            return try await dataSource.hospitals(sidoId: sidoId, sigunguId: sigunguId, eupmundongId: eupmundongId)
                .map { $0.toDomain() }
        } catch {
            Logger().error("병원 데이터를 불러오는 중 오류 발생: sidoId: \(sidoId), sigunguId: \(sigunguId), eupmundongId \(eupmundongId ?? -1): \(error.localizedDescription)")
            throw error
        }
    }
}
