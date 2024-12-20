//
//  HospitalRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

protocol HospitalRepository {
    func hospitals(sidoId: Int, sigunguId: Int, eupmundongId: Int?) async throws -> [Hospital]
    func getHospitals(sido: Int, sigungu: Int, eupmundong: Int, lat: Double, lon: Double) async throws -> [Hospital]
    func getHospitalDetails(hospitalId: Int) async throws -> Hospital
    func hospitalImage(filePath: String) async throws -> URL?
}
