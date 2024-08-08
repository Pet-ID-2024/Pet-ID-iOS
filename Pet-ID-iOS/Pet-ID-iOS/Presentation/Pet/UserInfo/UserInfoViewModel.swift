//
//  UserInfoViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/4/24.
//

import SwiftUI
import Combine

enum UserInfoState {
    case valid
    case invalid
    case back
}

class UserInfoViewModel: BaseViewModel<UserInfoState> {
    @Published var user: UserModel
    @Published var isNextButtonDisabled: Bool = true
    
    init(user: UserModel = UserModel(name: "", phoneNumber: "", address: "", detailAddress: "")) {
        self.user = user
        super.init()
        validateInput()
    }
    
    func updateName(_ newName: String) {
        let filtered = newName.filter { $0.isLetter }
        if filtered != user.name {
            user.name = filtered
            validateInput()
        }
    }
    
    func updatePhoneNumber(_ newPhoneNumber: String) {
        user.phoneNumber = newPhoneNumber
        validateInput()
    }
    
    func updateAddress(_ newAddress: String) {
        user.address = newAddress
        validateInput()
    }
    
    func updateDetailAddress(_ newDetailAddress: String) {
        user.detailAddress = newDetailAddress
        validateInput()
    }
    
    func validateInput() {
        let isValid = !user.name.isEmpty &&
        !user.phoneNumber.isEmpty &&
        user.phoneNumber.allSatisfy({ $0.isNumber }) &&
        !user.address.isEmpty
        isNextButtonDisabled = !isValid
        if isValid {
            result.send(.valid)
        } else {
            result.send(.invalid)
        }
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
