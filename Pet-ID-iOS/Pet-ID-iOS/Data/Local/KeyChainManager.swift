//
//  KeyChainManager.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

// 키체인에 대한 작업을 처리하는 구조체
struct KeychainManager: KeychainManagerProtocol {

    var keychain: KeychainProtocol
    
    // 초기화 메서드
    // parameter keychain: 키체인 작업을 처리할 객체(기본값은 KeyChain)
    init(keychain: KeychainProtocol = Keychain()) {
        self.keychain = keychain
    }

    // 키체인에 데이터 저장
    // - Key: 저장할 데이터 키
    // - data: 저장할 데이터
    // - Returns: 저장 성공 여부
    func save(key: Constants.KeychainKey, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue, // 데이터 저장을 위한 키
            kSecValueData as String: data   //저장될 데이터를 Data Type으로
        ]

        let status = keychain.add(query)
        
        if status != errSecSuccess { Logger().error("Keychain 저장 실패 \nkey:\(key)") }
        return status == errSecSuccess ? true : false // status가 errSecSuccess로 저장에 성공하면 true, else false
    }

    // 키체인에서 데이터를 로드
    // key: 로드할 데이터의 키
    // returns: 로드된 데이터, 없으면 nil
    func load(key: Constants.KeychainKey) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,             // 데이터를 리턴할지
            kSecMatchLimit as String: kSecMatchLimitOne //값이 일치하는 1개의 데이터만
        ]

        return keychain.search(query)
    }

    // 키체인에서 데이터를 삭제
    // key: 삭제할 데이터의 키
    // Returns: 삭제 성공 여부
    func delete(key: Constants.KeychainKey) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]

        let status = keychain.delete(query)
        
        if status != errSecSuccess { Logger().error("Keychain 삭제 실패 \nkey:\(key)") }
        
        return status == errSecSuccess ? true : false
    }

    // 키체인에 저장된 데이터를 업데이트
    // key: 업데이트할 데이터의 키
    // data: 업데이트할 데이터
    // returns: 업데이트 성공 여부
    func update(key: Constants.KeychainKey, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]

        let attributes: [String: Any] = [
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]

        let status = keychain.update(query, with: attributes)
        
        if status != errSecSuccess { Logger().error("Keychain 업데이트 실패 \nkey:\(key)") }
        
        return status == errSecSuccess ? true : false
    }
}
