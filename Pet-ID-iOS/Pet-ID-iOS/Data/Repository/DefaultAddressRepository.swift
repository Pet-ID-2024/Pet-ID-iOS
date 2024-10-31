//
//  DefaultAddressRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation

struct DefaultAddressRepository: AddressRepository {
    
    let dataSource: AddressDataSource
    
    init(dataSource: AddressDataSource = DefaultAddressDataSource()) {
        self.dataSource = dataSource
    }
    
    func sido() async throws -> [Location] {
        try await dataSource.sido()
            .map { $0.toDomain() }
    }
    
    func sigungu(sidoId: Int) async throws -> [Location] {
        try await dataSource.sigungu(sidoId: sidoId)
            .map { $0.toDomain() }
    }
    
    func eupmundong(sigunguId: Int) async throws -> [Location] {
        try await dataSource.eupmundong(sigunguId: sigunguId)
            .map{ $0.toDomain() }
    }
    
}


