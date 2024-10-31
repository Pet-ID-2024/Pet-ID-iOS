//
//  AddressFetcher.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation

protocol AddressFetcher {
    func sido() async throws -> [Location]
    func sigungu(sidoId: Int) async throws -> [Location]
    func eupmundong(sigunguId: Int) async throws -> [Location]
}

struct DefaultAddressFetcher: AddressFetcher {
    
    private let repository: AddressRepository
    
    init(
        repository: AddressRepository = DefaultAddressRepository()
    ) {
        self.repository = repository
    }
    
    func sido() async throws -> [Location] {
        try await repository.sido()
    }
    
    func sigungu(sidoId: Int) async throws -> [Location] {
        try await repository.sigungu(sidoId: sidoId)
    }
    
    func eupmundong(sigunguId: Int) async throws -> [Location] {
        try await repository.eupmundong(sigunguId: sigunguId)
    }
}
