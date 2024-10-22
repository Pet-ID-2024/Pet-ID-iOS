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
    
    
    
    case captionicon
    case chevronicon
    case petidicon
    case petidiconok
    case petidmain
    case refreshicon
    case filtericon
    case searchicon
    
    case placeicon
    case rscallicon
    case personicon
    case timeicon
    case randomicon
    
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
