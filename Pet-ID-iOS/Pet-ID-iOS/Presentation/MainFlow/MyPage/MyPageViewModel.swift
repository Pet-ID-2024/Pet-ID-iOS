//
//  MyPageViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/9/24.
//

import Foundation

enum MyPageState {
    case userInfo
    case petInfo
    case reservation
    case accessibilityRight
    case privacyPolicy
    case information
    case qna
    case withdraw
}

class MyPageViewModel: BaseViewModel<MyPageState> {
    func navigateToUser() {
        result.send(.userInfo)
    }
    
    func navigateToPet() {
        result.send(.petInfo)
    }
    
    func navigateToReservationList() {
        result.send(.reservation)
    }
}
