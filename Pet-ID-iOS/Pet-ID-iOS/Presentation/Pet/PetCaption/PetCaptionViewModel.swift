//
//  PetCaptionViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/5/24.
//

import Foundation
import Combine

enum PetCaptionViewModelResult {
    case completed
    case nextStep
    case back
}

class PetCaptionViewModel: BaseViewModel<PetCaptionViewModelResult> {
    func navigateToCamera() {
        result.send(.completed)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
