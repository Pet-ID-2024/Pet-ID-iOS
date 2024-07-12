//
//  KeychainProtocol.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

protocol KeychainProtocol {
    func add(_ query: [String: Any]) -> OSStatus
    func search(_ query: [String: Any]) -> Data?
    func update(_ query: [String: Any], with attributes: [String: Any]) -> OSStatus
    func delete(_ query: [String: Any]) -> OSStatus
}
