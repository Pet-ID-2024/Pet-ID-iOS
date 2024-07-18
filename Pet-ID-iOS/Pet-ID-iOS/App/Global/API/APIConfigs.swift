//
//  APIConfigs.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

struct APIConfigs {
    enum Key {
        static let kakaoAppKey: String = "e73834f33dc8405c99f414788b9b1b23"
    }
    enum Network {
        static let domain: String = "http://43.203.1.26:8080" // 서버 도메인
    }
    
    private init() {}
}

