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
        do {
            return try await dataSource.sido()
                .map { $0.toDomain() }
        } catch {
            Logger().error("시/도 데이터를 불러오는 중 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
    
    func sigungu(sidoId: Int) async throws -> [Location] {
        do {
            return try await dataSource.sigungu(sidoId: sidoId)
                .map { $0.toDomain() }
        } catch {
            Logger().error("시군구 데이터를 불러오는 중 오류 발생 (sidoId: \(sidoId)): \(error.localizedDescription)")
            throw error
        }
    }
    
    func eupmundong(sigunguId: Int) async throws -> [Location] {
        do {
            return try await dataSource.eupmundong(sigunguId: sigunguId)
                .map { $0.toDomain() }
        } catch {
            Logger().error("읍면동 데이터를 불러오는 중 오류 발생 (sigunguId: \(sigunguId)): \(error.localizedDescription)")
            throw error
        }
    }
}
