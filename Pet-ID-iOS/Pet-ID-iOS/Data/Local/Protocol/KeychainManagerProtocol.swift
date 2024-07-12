//
//  KeychainManagerProtocol.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

protocol KeychainManagerProtocol {
    func save(key: Constants.KeychainKey, data: Data) -> Bool
    func load(key: Constants.KeychainKey) -> Data?
    func delete(key: Constants.KeychainKey) -> Bool
    func update(key: Constants.KeychainKey, data: Data) -> Bool
}
