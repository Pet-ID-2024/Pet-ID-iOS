//
//  PetIDDataSource.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/18/24.
//

import Foundation
import Moya

protocol PetIDDataSource {
    func registerType(request: PetIDRequestDTO) async throws -> PetIDResponseDTO
}

struct DefaultPetIDDataSource: PetIDDataSource {
    private let provider = Provider<PetIDAPI>()
    
    func registerType(request: PetIDRequestDTO) async throws -> PetIDResponseDTO {
        Logger().debug("📡 PetIDDataSource - registerType 요청 시작: \(request.chipType)")
        
        do {
            let response: PetIDResponseDTO = try await provider.request(.registerType(request: request))
            Logger().debug("✅ PetIDDataSource - 응답 수신 성공: \(response)")
            return response
        } catch {
            Logger().error("❌ PetIDDataSource - 요청 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
