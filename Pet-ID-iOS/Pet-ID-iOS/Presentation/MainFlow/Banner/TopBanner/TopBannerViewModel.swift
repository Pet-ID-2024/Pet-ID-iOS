//
//  BannerViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI
import Combine

struct TopBannerModel {
    let title: String
    let subtitle: String
    let icon: Image
}

class TopBannerViewModel: BaseViewModel<TopBannerModel> {
    
    @Published var banner: TopBannerModel
    
    init(banner: TopBannerModel) {
        self.banner = banner
        super.init()
    }
}
