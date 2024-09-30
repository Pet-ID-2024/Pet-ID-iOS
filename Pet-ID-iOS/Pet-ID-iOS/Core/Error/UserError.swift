//
//  UserError.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

// 사용자 오류 나타내는 열거형
enum UserError: Error {
    // 다른 오류를 포함하는 경우
    case anyError(Error)
    // 사용자 데이터를 찾을 수 없는 경우
    case userDataNotFound
}
