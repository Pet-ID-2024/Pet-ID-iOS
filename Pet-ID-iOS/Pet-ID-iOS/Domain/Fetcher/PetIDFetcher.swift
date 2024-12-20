//
//  PetIDFetcher.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/18/24.
//

import Foundation


protocol PetIDFetcher {
    func registerType(request: PetIDRequestDTO) async throws -> PetDetails
}


struct DefaultPetIDFetcher: PetIDFetcher {
    
    private let repository: PetIDRepository
    
    init(repository: PetIDRepository = DefaultPetIDRepository()) {
        self.repository = repository
    }
    
    func registerType(request: PetIDRequestDTO) async throws -> PetDetails {
        Logger().debug("📡 DefaultPetIDFetcher - registerChipType 요청 시작: chipType=\(request.chipType)")
        do {
            let response = try await repository.registerType(request: request)
            Logger().debug("✅ DefaultPetIDFetcher - registerChipType 요청 성공: \(response)")
            return response
        } catch {
            Logger().error("❌ DefaultPetIDFetcher - registerChipType 요청 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
