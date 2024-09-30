//
//  ErrorModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

// 서버에서 발생한 에러 정보를 담는 구조체
struct ErrorModel: Codable {
    var timestamp: UInt64 // 에러 발생 시간
    var status: UInt // HTTP 상태 코드
    var error: String // 에러 메시지
    var path: String // 요청한 API 경로
}
