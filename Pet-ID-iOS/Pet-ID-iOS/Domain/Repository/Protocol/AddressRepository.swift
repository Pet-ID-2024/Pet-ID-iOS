//
//  AddressRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation

protocol AddressRepository {
    func sido() async throws -> [Location]
    func sigungu(sidoId: Int) async throws -> [Location]
}
