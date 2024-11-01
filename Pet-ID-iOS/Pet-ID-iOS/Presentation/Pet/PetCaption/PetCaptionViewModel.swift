//
//  PetCaptionViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/5/24.
//

import Foundation
import Combine

enum PetCaptionState {
    case completed
    case nextStep
    case back
}

class PetCaptionViewModel: BaseViewModel<PetCaptionState> {
    func navigateToCamera() {
        result.send(.completed)
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func navigateToScan() {
        result.send(.nextStep)
    }
}
