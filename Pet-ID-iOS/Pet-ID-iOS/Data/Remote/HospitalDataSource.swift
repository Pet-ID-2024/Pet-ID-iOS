//
//  HospitalDataSource.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

protocol HospitalDataSource {
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [HospitalResponseDTO]
    func getHospitals(sido: Int, sigungu: Int, eupmundong: Int, lat: Double, lon: Double) async throws -> [HospitalResponseDTO]
    func getHospitalDetail(hospitalId: Int) async throws -> Hospital
    func hospitalImage(filePath: String) async throws -> URL?
}

struct DefaultHospitalDataSource: HospitalDataSource {
    private let provider = Provider<HospitalAPI>()
    
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [HospitalResponseDTO] {
//        Logger().debug("📡 HospitalDataSource 요청 시작 - sidoId: \(sidoId), sigunguId: \(sigunguId), eupmundongId: \(String(describing: eupmundongId))")
        let response: [HospitalResponseDTO] = try await provider.request(.hospitals(sido: sidoId, sigunguId: sigunguId, eupmundong: eupmundongId))
//        Logger().debug("✅ 응답 완료 - 병원 데이터 조회: \(response)")
        return response
    }
    
    func getHospitals(sido: Int, sigungu: Int, eupmundong: Int, lat: Double, lon: Double) async throws -> [HospitalResponseDTO] {
//        Logger().debug("📡 HospitalDataSource 거리순 정렬 요청 시작 - sido: \(sido), sigungu: \(sigungu), eupmundong: \(String(describing: eupmundong)), lat: \(lat), lon: \(lon)")
        let response: [HospitalResponseDTO] = try await provider.request(.getHospitals(sido: sido, sigungu: sigungu, eupmundong: eupmundong, lat: lat, lon: lon))
//        Logger().debug("✅ 응답 완료 - 병원 데이터 조회: \(response)")
        return response
    }
    
    func getHospitalDetail(hospitalId: Int) async throws -> Hospital {
//        Logger().debug("📡 HospitalDataSource 조회 요청 시작 - hospitalId: \(hospitalId)")
        let response: HospitalResponseDTO = try await provider.request(.getHospitalDetail(hospitalId: hospitalId))
//        Logger().debug("✅ 응답 완료 - 병원 조회: \(response)")
        return response.toDomain()
    }
    
    func hospitalImage(filePath: String) async throws -> URL? {
        Logger().debug("📡 HospitalDataSource 이미지 요청 시작 - filePath: \(filePath)")
        
        do {
            let responseString: String = try await provider.requestString(.hospitalImage(filePath: filePath))
            
            guard let url = URL(string: responseString) else {
                throw URLError(.badURL)
            }
            return url
        } catch {
            throw error
        }
    }
}
