//
//  AggreementType.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

enum AgreementType {
    case required
    case optional
    
    var title: String {
        switch self {
        case .required: return "필수"
        case .optional: return "선택"
        }
    }
}
