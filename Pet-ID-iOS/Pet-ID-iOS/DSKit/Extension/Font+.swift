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
        return Font.custom("NotoSansKR-\(fontWeight.toString)", size: fontSize)
    }
    
    static let headline1 = Font.notoSansKR(fontSize: 24, fontWeight: .medium)
    static let headline2 = Font.notoSansKR(fontSize: 22, fontWeight: .bold)
    static let headline3_bold = Font.notoSansKR(fontSize: 20, fontWeight: .bold)
    static let headline3_med = Font.notoSansKR(fontSize: 20, fontWeight: .medium)
    static let body1_bold = Font.notoSansKR(fontSize: 18, fontWeight: .bold)
    static let body1_semi = Font.notoSansKR(fontSize: 18, fontWeight: .semibold)
    static let body1_med = Font.notoSansKR(fontSize: 18, fontWeight: .medium)
    static let body1_reg = Font.notoSansKR(fontSize: 18, fontWeight: .regular)
    static let body2_bold = Font.notoSansKR(fontSize: 16, fontWeight: .bold)
    static let body2_med = Font.notoSansKR(fontSize: 16, fontWeight: .medium)
    static let body2_reg = Font.notoSansKR(fontSize: 16, fontWeight: .regular)
    static let body3_bold = Font.notoSansKR(fontSize: 14, fontWeight: .bold)
    static let body3_med = Font.notoSansKR(fontSize: 14, fontWeight: .medium)
    static let body3_reg = Font.notoSansKR(fontSize: 14, fontWeight: .regular)
    static let body4_med = Font.notoSansKR(fontSize: 13, fontWeight: .medium)
    static let body4_reg = Font.notoSansKR(fontSize: 13, fontWeight: .regular)
    static let caption1_med = Font.notoSansKR(fontSize: 13, fontWeight: .medium)
    static let caption1_reg = Font.notoSansKR(fontSize: 13, fontWeight: .regular)
    static let popup_med = Font.notoSansKR(fontSize: 20, fontWeight: .medium)
    static let headline15 = Font.notoSansKR(fontSize: 17, fontWeight: .semibold)
    
}
