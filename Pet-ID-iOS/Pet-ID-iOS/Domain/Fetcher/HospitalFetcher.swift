//
//  HospitalFetcher.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

protocol HospitalFetcher {
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [Hospital]
    func getHospitals(sido: Int, sigungu: Int, eupmundong: Int, lat: Double, lon: Double) async throws -> [Hospital]
    func getHospitalDetail(hospitalId: Int) async throws -> Hospital
    func hospitalImage(filePath: String) async throws -> URL?
}

struct DefaultHospitalFetcher: HospitalFetcher {
    
    private let repository: HospitalRepository
    
    init(repository: HospitalRepository = DefaultHospitalRepository()) {
        self.repository = repository
    }
    
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [Hospital] {
//        Logger().debug("🟢 HospitalFetcher 호출 - sidoId: \(sidoId), sigunguId: \(sigunguId), eupmundongId: \(eupmundongId ?? -1)")
        
        do {
            let hospitals = try await repository.hospitals(sidoId: sidoId, sigunguId: sigunguId, eupmundongId: eupmundongId)
//            Logger().debug("✅ HospitalFetcher 응답 완료 - 병원 데이터 수: \(hospitals.count)")
            return hospitals
        } catch {
            Logger().error("❌ HospitalFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
    
    func getHospitals(sido: Int, sigungu: Int, eupmundong: Int, lat: Double, lon: Double) async throws -> [Hospital] {
//        Logger().debug("🟢🟢🟢🟢🟢sido: \(sido), sigungu: \(sigungu), eupmundong: \(eupmundong), lat: \(lat), lon: \(lon)")
        
        do {
            let hospitals = try await repository.getHospitals(sido: sido, sigungu: sigungu, eupmundong: eupmundong, lat: lat, lon: lon)
//            Logger().debug("✅✅✅✅✅ 병원 데이터 수: \(hospitals.count)")
            return hospitals
        } catch {
            Logger().error("❌❌❌❌❌ HospitalFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
    
    func getHospitalDetail(hospitalId: Int) async throws -> Hospital {
//        Logger().debug("🟢 Hospital 조회 요청 - hospitalId: \(hospitalId)")
        
        do {
            let detail = try await repository.getHospitalDetails(hospitalId: hospitalId)
//            Logger().debug("✅ 병원 조회 ID: \(hospitalId)")
            return detail
        } catch {
            Logger().debug("❌ HospitalFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
    
    func hospitalImage(filePath: String) async throws -> URL? {
        Logger().debug("[DefaultHospitalFetcher] 🟢 Hospital 이미지 요청 - filePath: \(filePath)")
        
        do {
            let imageUrl = try await repository.hospitalImage(filePath: filePath)
            Logger().debug("[DefaultHospitalFetcher] ✅ Hospital 이미지 응답 완료: \(String(describing: imageUrl))")
            return imageUrl
        } catch {
            Logger().debug("[DefaultHospitalFetcher] ❌ Hospital 이미지 요청 중 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
}
