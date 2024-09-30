//
//  KeychainProtocol.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

// 케체인에 대한 기본적인 CRUD 작업 정의 프로토콜
protocol KeychainProtocol {
    // 새로운 항목을 키체인에 추가
    // query: 추가할 항목의 쿼리
    // OSStatus: 성공 여부를 나타내는 OSStatus
    func add(_ query: [String: Any]) -> OSStatus
    
    // 키체인에서 항목 검색
    // query: 검색할 항목의 쿼리
    // returns: 검색된 데이터, 없으면 nil
    func search(_ query: [String: Any]) -> Data?
    
    // 키체인에서 항목 업데이트
    // query: 업데이트할 항목의 쿼리
    // attributes: 업데이트할 속성
    // returns: 성공 여부를 나타내는 OSStatus
    func update(_ query: [String: Any], with attributes: [String: Any]) -> OSStatus
    
    // 키체인에서 항목 삭제
    // query: 삭제할 항목의 쿼리
    // returns: 성공 여부를 나타내는 OSStatus
    func delete(_ query: [String: Any]) -> OSStatus
}
