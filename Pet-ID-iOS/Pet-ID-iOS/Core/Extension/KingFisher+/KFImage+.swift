//
//  KFImage+.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import Kingfisher
import Foundation

extension KFImage {
    
    init(string: String?) {
        self.init(URL(string: string ?? ""))
    }
    
}
