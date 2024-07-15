//
//  Image+.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/13/24.
//

import SwiftUI

public enum DSImage {
    
    case checkbtn
    case checkicon
    case checkimage
    
    case apple
    case google
    case kakao
    case naver
    
    case splashimage
    
    case phoneicon
    case galleryicon
    case notificationicon
    case callicon
    case cameraicon
    case infoicon
    
    
    var toName: String {
        switch self {
        case .checkbtn:
            return "checkbtn"
        case .checkicon:
            return "checkicon"
        case.checkimage:
            return "checkimage"
            
        case .apple:
            return "apple"
        case .google:
            return "google"
        case .kakao:
            return "kakao"
        case .naver:
            return "naver"
            
        case .splashimage:
            return "splashimage"
            
        case .callicon:
            return "callicon"
        case .notificationicon:
            return "notificationicon"
        case .cameraicon:
            return "cameraicon"
        case .galleryicon:
            return "galleryicon"
        case .phoneicon:
            return "phoneicon"
        case .infoicon:
            return "infoicon"
        }
    }
}

public extension DSImage {
    func uiImage() -> Image {
        Image(uiImage: UIImage(named: self.toName)!)
    }
}
