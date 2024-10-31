//
//  KeyChainManager.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

struct KeychainManager: KeychainManagerProtocol {

    var keychain: KeychainProtocol
    
    init(keychain: KeychainProtocol = Keychain()) {
        self.keychain = keychain
    }

    func save(key: Constants.KeychainKey, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue, // 데이터 저장을 위한 키
            kSecValueData as String: data   //저장될 데이터를 Data Type으로
        ]

        let status = keychain.add(query)
        
        if status == errSecSuccess {
                print("🔐 Keychain 저장 성공 - Key: \(key), Data: \(String(data: data, encoding: .utf8) ?? "데이터 없음")")
            } else {
                Logger().error("Keychain 저장 실패 \nkey:\(key)")
            }

            return status == errSecSuccess
    }

    func load(key: Constants.KeychainKey) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,             // 데이터를 리턴할지
            kSecMatchLimit as String: kSecMatchLimitOne //값이 일치하는 1개의 데이터만
        ]

        return keychain.search(query)
    }

    func delete(key: Constants.KeychainKey) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]

        let status = keychain.delete(query)
        
        if status != errSecSuccess { Logger().error("Keychain 삭제 실패 \nkey:\(key)") }
        
        return status == errSecSuccess ? true : false
    }

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
        
        if status == errSecSuccess {
                print("🔄 Keychain 업데이트 성공 - Key: \(key), Data: \(String(data: data, encoding: .utf8) ?? "데이터 없음")")
            } else {
                Logger().error("Keychain 업데이트 실패 \nkey:\(key)")
            }

            return status == errSecSuccess
    }
}

//import Foundation
//
//struct KeychainManager: KeychainManagerProtocol {
//
//    var keychain: KeychainProtocol
//
//    init(keychain: KeychainProtocol = Keychain()) {
//        self.keychain = keychain
//    }
//
//    // MARK: - Keychain 저장
//    func save(key: Constants.KeychainKey, data: Data) -> Bool {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: key.rawValue,
//            kSecValueData as String: data
//        ]
//
//        let status = keychain.add(query)
//
//        if status != errSecSuccess {
//            logError(status, message: "Keychain 저장 실패", key: key)
//        }
//        return status == errSecSuccess
//    }
//
//    // MARK: - Keychain 로드
//    func load(key: Constants.KeychainKey) -> Data? {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: key.rawValue,
//            kSecReturnData as String: true,
//            kSecMatchLimit as String: kSecMatchLimitOne
//        ]
//
//        guard let data = keychain.search(query) else {
//            Logger().error("Keychain 로드 실패: 데이터가 없음\nkey: \(key)")
//            return nil
//        }
//        return data
//    }
//
//    // MARK: - Keychain 삭제
//    func delete(key: Constants.KeychainKey) -> Bool {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: key.rawValue
//        ]
//
//        let status = keychain.delete(query)
//
//        if status != errSecSuccess {
//            logError(status, message: "Keychain 삭제 실패", key: key)
//        }
//
//        return status == errSecSuccess
//    }
//
//    // MARK: - Keychain 업데이트
//    func update(key: Constants.KeychainKey, data: Data) -> Bool {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: key.rawValue
//        ]
//
//        let attributes: [String: Any] = [
//            kSecValueData as String: data
//        ]
//
//        let status = keychain.update(query, with: attributes)
//
//        if status != errSecSuccess {
//            logError(status, message: "Keychain 업데이트 실패", key: key)
//        }
//
//        return status == errSecSuccess
//    }
//
//    // MARK: - 에러 메시지 로깅 함수
//    private func logError(_ status: OSStatus, message: String, key: Constants.KeychainKey) {
//        if let errorMessage = SecCopyErrorMessageString(status, nil) {
//            Logger().error("\(message) (\(key.rawValue)): \(errorMessage)")
//        } else {
//            Logger().error("\(message) (\(key.rawValue)): 알 수 없는 에러 발생")
//        }
//    }
//}
