//
//  UserInfoViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/4/24.
//

import SwiftUI
import Combine

class UserInfoViewModel: BaseViewModel<Bool> {
    @Published var user: UserModel
    @Published var isNextButtonActive: Bool = false
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
        isNextButtonDisabled = user.name.isEmpty || user.phoneNumber.isEmpty || !user.phoneNumber.allSatisfy({ $0.isNumber }) || user.address.isEmpty
        
        if !isNextButtonDisabled {
            result.send(true)
        }
    }
}
