//
//  BaseTargetType.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: APIConfigs.Network.domain)!
    }
    
    var headers: [String : String]? { nil }
}
