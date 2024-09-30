//
//  Constants.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

struct Constants {
    enum KeychainKey: String {
        // 사용자 인증 정보를 저장할 때 사용할 키(Keychain에 저장되는 항목의 키)
        case authorization = "com.petid.authorization"
    }
}
