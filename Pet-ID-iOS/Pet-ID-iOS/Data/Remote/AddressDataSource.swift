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
        try await provider.request(.sido)
    }
    
    func sigungu(sidoId: Int) async throws -> [LocationResponseDTO] {
        try await provider.request(.sigungu(sidoId: sidoId))
    }
    
    func eupmundong(sigunguId: Int) async throws -> [LocationResponseDTO] {
        try await provider.request(.eupmundong(sigunguId: sigunguId))
    }
}
