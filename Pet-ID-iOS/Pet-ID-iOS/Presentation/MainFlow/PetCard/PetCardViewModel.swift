//
//  PetCardViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI
import Combine

struct PetInfoModel {
    let mainText: String
    let subText: String
    let buttonText: String
}

class PetCardViewModel: BaseViewModel<PetInfoModel> {
    
    @Published var card: PetInfoModel
    
    override init() {
        
        self.card = PetInfoModel(
            mainText: "반려동물을 지키는\n가장 확실한 방법이에요.",
            subText: "펫 아이디 만들고\n간편하게 등록해보세요.",
            buttonText: "시작하기"
        )
    }
}
