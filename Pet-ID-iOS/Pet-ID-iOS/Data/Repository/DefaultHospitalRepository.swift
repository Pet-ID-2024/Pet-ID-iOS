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
            let eupmundongDisplay = eupmundongId != nil ? "\(eupmundongId!)" : "nil"
            
            Logger().error("병원 데이터를 불러오는 중 오류 발생: sidoId: \(sidoId), sigunguId: \(sigunguId), eupmundongId: \(eupmundongDisplay): \(error.localizedDescription)")
            
            throw error
        }
    }
    
    func getHospitals(sido: Int, sigungu: Int, eupmundong: Int, lat: Double, lon: Double) async throws -> [Hospital] {
        
        do {
            return try await dataSource.getHospitals(sido: sido, sigungu: sigungu, eupmundong: eupmundong, lat: lat, lon: lon)
                .map{ $0.toDomain() }
        } catch {
            Logger().error("거리순 정렬 데이터를 불러오는 중 오류 발생: sido: \(sido), sigungu: \(sigungu), eupmundong: \(eupmundong), lat: \(lat), lon: \(lon): \(error.localizedDescription)")
            
            throw error
        }
    }
    
    func getHospitalDetails(hospitalId: Int) async throws -> Hospital {
        do {
            return try await dataSource.getHospitalDetail(hospitalId: hospitalId)
        } catch {
            Logger().error("조회 요청 중 오류 발생: hospitalId: \(hospitalId), 오류: \(error.localizedDescription)")
            throw error
        }
    }
    
    func hospitalImage(filePath: String) async throws -> URL? {
        return try await dataSource.hospitalImage(filePath: filePath)
    }
}
