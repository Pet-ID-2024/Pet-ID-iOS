//
//  UserInfoDetailViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/9/24.
//

import Foundation

enum PetInfoDetailState {
    case edit
    case back
}

class PetInfoDetailViewModel: BaseViewModel<PetInfoDetailState> {
    func navigateToEdit() {
        result.send(.edit)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
