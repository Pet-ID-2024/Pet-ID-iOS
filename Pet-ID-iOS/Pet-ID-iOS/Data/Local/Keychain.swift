//
//  Keychain.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

struct Keychain: KeychainProtocol {
    
    /// 주어진 query를 사용하여 Keychain에 항목을 추가한다.
    /// - Parameter query: Keychain에 추가할 항목에 대한 쿼리 파라미터
    /// - Returns: 작업의 성공 여부
    func add(_ query: [String: Any]) -> OSStatus {
        // Keychain에 항목을 추가하는 메서드.. query 정보를 기반으로 keychain에 새로운 항목이 추가된다.
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    
    /// Keychain에서 항목을 검색하는 메서드
    /// - Parameter query: 검색할 항목에 대한 쿼리 파라미터
    /// - Returns: Data or nil
    func search(_ query: [String: Any]) -> Data? {
        var item: CFTypeRef? // keychain에서 검색된 항목을 담을 변수
        // query를 기반으로 keychain에서 검색, &item을 전달하여 검색 결과를 item에 저장, status에는 검색의 성공 여부와 관련된 상태코드가 담긴다.
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        return status == noErr ? (item as? Data) : nil // status가 성공이라면 item을 Data타입으로 캐스팅하여 리턴.
    }
    
    
    /// KeyChain Update
    /// - Parameters:
    ///   - query: query
    ///   - attributes: 업데이트할 속성을 포함한 쿼리파라미터
    /// - Returns: 작업의 성공 여부
    func update(_ query: [String: Any], with attributes: [String: Any]) -> OSStatus {
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
    }
    

    
    /// Keychain Delete
    /// - Parameter query: query
    /// - Returns: 작업의 성공 여부
    func delete(_ query: [String: Any]) -> OSStatus {
        return SecItemDelete(query as CFDictionary)
    }
}
