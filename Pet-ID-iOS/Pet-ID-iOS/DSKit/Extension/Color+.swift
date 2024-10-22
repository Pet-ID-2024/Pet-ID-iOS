//
//  Color+.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/10/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    static let petid_skyblue = Color(hex: "#84C6FF")
    static let petid_lightdark_skyblue = Color(hex: "#79B2E4")
    static let petid_clearblue = Color(hex: "#3397FF")
    static let petid_lightgray = Color(hex: "#D9D9D9")
    static let petid_gray = Color(hex: "#838383")
    static let petid_subtitle = Color(hex: "#848484")
    static let petid_blue = Color(hex: "#007DFF")
    static let petid_title = Color(hex: "#242424")
    static let petid_fa = Color(hex: "#fafafa")
    static let petid_f5 = Color(hex: "#f5f5f5")
    static let petid_d9 = Color(hex: "#d9d9d9")
    static let petid_e3 = Color(hex: "#e3e3e3")
    static let petid_e9 = Color(hex: "#e9e9e9")
    static let petid_ab = Color(hex: "#ababab")
    static let petid_b4 = Color(hex: "#b4b4b4")
    static let petid_b9 = Color(hex: "#9b9b9b")
    static let petid_f7 = Color(hex: "#7f7f7f")
    static let petid_top_sub = Color(hex: "#787C81")
    static let petid_f2 = Color(hex: "#f2f2f2")
    static let petid_banner_pink = Color(hex: "#FFEEF6")
    static let petid_caution_red = Color(hex: "#D0180B")
    static let petid_button = Color(hex: "#E4F3FF")
    static let petid_gu2 = Color(hex: "#929292")
    static let petid_f4 = Color(hex: "#F4F4F4")
    static let petid_under_bar = Color(hex: "#515151")
}


