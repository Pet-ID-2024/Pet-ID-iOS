//
//  ErrorModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

struct ErrorModel: Codable {
    var timestamp: UInt64
    var status: UInt
    var error: String
    var path: String
}
