//
//  BannerViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI
import Combine

struct BannerModel {
    let title: String
    let subtitle: String
    let icon: Image
}

class BannerViewModel: BaseViewModel<BannerModel> {
    
    @Published var banner: BannerModel
    
    init(banner: BannerModel) {
        self.banner = banner
        super.init()
    }
}
