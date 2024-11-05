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
        do {
            return try await repository.sido()
        } catch {
            Logger().error("시/도 데이터 로드 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    func sigungu(sidoId: Int) async throws -> [Location] {
        do {
            return try await repository.sigungu(sidoId: sidoId)
        } catch {
            Logger().error("시군구 데이터 로드 실패 (sidoId: \(sidoId)): \(error.localizedDescription)")
            throw error
        }
    }
    
    func eupmundong(sigunguId: Int) async throws -> [Location] {
        do {
            return try await repository.eupmundong(sigunguId: sigunguId)
        } catch {
            Logger().error("읍면동 데이터 로드 실패 (sigunguId: \(sigunguId)): \(error.localizedDescription)")
            throw error
        }
    }
}
