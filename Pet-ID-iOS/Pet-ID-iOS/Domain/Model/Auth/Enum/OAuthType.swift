//
//  OAuthType.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

enum OAuthType {
    case kakao
    case google
    case apple
    case naver
    
    var toServerString: String {
        switch self {
        case .kakao: return "kakao"
        case .google: return "google"
        case .apple: return "apple"
        case .naver: return "naver"
        }
    }
}
