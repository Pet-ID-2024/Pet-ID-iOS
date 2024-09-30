//
//  AppDelegate+Cache.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Foundation
import Kingfisher
import SwiftUI

extension AppDelegate {
    
    func settingCache() {
        settingImageCache()
    }
    
    func settingImageCache() {
        
        let cache = ImageCache.default
        
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024 // 100MB
        cache.memoryStorage.config.countLimit = .max
        
        cache.diskStorage.config.sizeLimit = 100 * 1024 * 1024 // 100MB
        cache.diskStorage.config.expiration = .days(300)
    }
}
