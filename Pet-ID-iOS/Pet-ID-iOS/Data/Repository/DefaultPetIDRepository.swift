//
//  DefaultPetIDRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/18/24.
//

import Foundation

struct DefaultPetIDRepository: PetIDRepository {
    
    let dataSource: PetIDDataSource
    
    init(dataSource: PetIDDataSource = DefaultPetIDDataSource()) {
        self.dataSource = dataSource
    }
    
    func registerType(request: PetIDRequestDTO) async throws -> PetDetails {
        Logger().debug("📡 DefaultPetIDRepository - registerChipType 호출: chipType=\(request.chipType)")
        do {
            let response = try await dataSource.registerType(request: request)
            Logger().debug("✅ DefaultPetIDRepository - registerChipType 성공: \(response)")
            return response.toDomain()
        } catch {
            Logger().error("❌ Repository 오류 발생: registerChipType 실패: \(error.localizedDescription)")
            throw error
        }
    }
    
    func deletePet(petId: Int) async throws {
        Logger().debug("📡 DefaultPetIDRepository - deletePet 호출: petId=\(petId)")
        do {
            try await dataSource.deletePet(petId: petId)
            Logger().debug("✅ DefaultPetIDRepository - deletePet 성공: petId=\(petId)")
        } catch {
            Logger().error("❌ Repository 오류 발생: deletePet 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
