//
//  APIConfigs.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

// APIConfigs: 앱에서 사용하는 API 키와 네트워크 관련 설정값들을 정의

import Foundation

struct APIConfigs {
    // 카카오, 네이버 로그인등에서 필요한 API 키 관리
    enum Key {
        static let kakaoAppKey: String = "e73834f33dc8405c99f414788b9b1b23"
        static let urlScheme: String = "com.pet-id-iOS"
        static let naverClientID: String = "StRE9znYGIIGSMx1WZQT"
        static let naverClientSecret: String = "CeCpvGoU8m"
    }
    // 네트워크 관련 설정값 관리
    enum Network {
        static let domain: String = "http://43.203.1.26:8080" // 서버 도메인
    }
    
    // init 메서드를 private로 설정해 외부에서 APICofigs 구조체의 인스턴스를 생성ㄹ하지 못하도록 함
    private init() {}
}

