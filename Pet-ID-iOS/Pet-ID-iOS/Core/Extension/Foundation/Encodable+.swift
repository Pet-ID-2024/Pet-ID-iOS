//
//  Encodable+.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

// Encodable 프로토콜을 준수하는 타입에 대한 익스텐션
extension Encodable {
    // 인스턴스를 Dictionary로 변환하는 메서드
    func toDictionary() -> [String: Any] {
        // 인스턴스를 JSON으로 인코딩하고, 이를 다시 Dictionary로 변환
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            return [:] // 실패 시 빈 Dictionary 반환
        }
        return dictionary // 변환된 Dictionary 반환
    }
}
