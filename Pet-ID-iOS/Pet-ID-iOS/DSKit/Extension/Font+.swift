//
//  Font+.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/13/24.
//

import SwiftUI

extension Font {
    
    enum CustomWeight {
        case regular
        case bold
        case semibold
        case medium
        
        var toString: String {
            switch self {
            case .regular: return "Regular"
            case .bold: return "Bold"
            case .semibold: return "SemiBold"
            case .medium: return "Medium"
            }
        }
    }
    static func notoSansKR(fontSize: CGFloat, fontWeight: CustomWeight) -> Font {
        return Font.custom("NotoSansKR-\(fontWeight)", size: fontSize)
    }
    
    static let petIdTitle1 = Font.notoSansKR(fontSize: 24, fontWeight: .medium)
    static let petIdTitle2 = Font.notoSansKR(fontSize: 22, fontWeight: .bold)
    static let petIdPopup = Font.notoSansKR(fontSize: 20, fontWeight: .medium)
    static let petIdTitle3 = Font.notoSansKR(fontSize: 18, fontWeight: .regular)
    static let petIdBody1 = Font.notoSansKR(fontSize: 16, fontWeight: .regular)
    static let petIdBody2 = Font.notoSansKR(fontSize: 14, fontWeight: .regular)
    static let petIdBody3 = Font.notoSansKR(fontSize: 13, fontWeight: .regular)
    static let petIdCaption1 = Font.notoSansKR(fontSize: 12, fontWeight: .regular)
    
    
}
