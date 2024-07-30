//
//  MainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/30/24.
//

import SwiftUI
import Combine

class MainViewModel: BaseViewModel<MainCoordinatorResult> {
    
    private var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator?) {
        self.coordinator = coordinator
        super.init()
    }
    
    @MainActor func showBanner() {
        coordinator?.showBanner()
    }
    
//    @MainActor func showPetCard() {
//        coordinator?.showPetCard()
//    }
}
