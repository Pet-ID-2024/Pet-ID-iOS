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
    
    static let petIdSkyBlue = Color(hex: "#84C6FF")
    static let petid_lightdark_skyblue = Color(hex: "#79B2E4")
    static let petid_clearblue = Color(hex: "#3397FF")
    static let petid_blue = Color(hex: "#007DFF")
    static let petid_clearblue_gradient = Color(hex: "#007DFF~#B4D9FF")
    static let petid_lightgrey = Color(hex: "#D9D9D9")
    static let petid_grey = Color(hex: "#838383")
    static let petid_subtitle = Color(hex: "#848484")
    static let petid_title = Color(hex: "#242424")
    static let petid_red = Color(hex: "#E54747")
}
