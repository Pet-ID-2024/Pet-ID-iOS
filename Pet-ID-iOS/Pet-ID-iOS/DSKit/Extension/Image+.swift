//
//  Image+.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/13/24.
//

import SwiftUI

public enum DSImage: String {
    
    case checkbtn
    case checkicon
    case checkimage
    
    case apple
    case google
    case kakao
    case naver
    
    case splashImage
    
    case phoneicon
    case galleryicon
    case notificationicon
    case callicon
    case cameraicon
    case infoicon
    
    case umbrellaicon
    case bannerbg
    case petidicon
    
    case captionicon
    
    var toName: String {
        return self.rawValue
    }
}

extension DSImage: LoggAble {
    func toImage() -> Image {
        
        if let uiImage = UIImage(named: self.toName) {
            return Image(uiImage: uiImage)
        } else {
            logger.error("Failed To Load DSImage \(self)")
            fatalError()
        }
    }
}
