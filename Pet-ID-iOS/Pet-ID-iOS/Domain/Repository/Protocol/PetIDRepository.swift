//
//  PetIDRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/18/24.
//

import Foundation

protocol PetIDRepository {
    func registerType(request: PetIDRequestDTO) async throws -> PetDetails
}
