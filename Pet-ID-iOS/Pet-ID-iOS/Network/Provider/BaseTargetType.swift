//
//  BaseTargetType.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

// Moya의 TargetType 프로토콜을 확장한 기본 타겟 프로토콜
protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    // API의 기본 URL 반환
    var baseURL: URL {
        return URL(string: APIConfigs.Network.domain)!
    }
    
    // API 요청에 사용할 헤더를 정의 기본값은 nil
    var headers: [String : String]? { nil }
}
