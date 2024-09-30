//
//  KeychainManagerProtocol.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

// 키체인에 대한 고수준 작업을 정의하는 프로토콜
protocol KeychainManagerProtocol {
    // 키체인에 데이터를 저장
    // - Parameters:
    //   - key: 데이터를 저장할 키
    //   - data: 저장할 데이터
    // - Returns: 저장 성공 여부
    func save(key: Constants.KeychainKey, data: Data) -> Bool
    
    // 키체인에서 데이터를 로드
    // - Parameter key: 로드할 데이터의 키
    // - Returns: 로드된 데이터, 없으면 nil
    func load(key: Constants.KeychainKey) -> Data?
    
    // 키체인에서 데이터를 삭제
    // - Parameter key: 삭제할 데이터의 키
    // - Returns: 삭제 성공 여부
    func delete(key: Constants.KeychainKey) -> Bool
    
    // 키체인에 저장된 데이터를 업데이트
    // - Parameters:
    //   - key: 업데이트할 데이터의 키
    //   - data: 업데이트할 데이터
    // - Returns: 업데이트 성공 여부
    func update(key: Constants.KeychainKey, data: Data) -> Bool
}
