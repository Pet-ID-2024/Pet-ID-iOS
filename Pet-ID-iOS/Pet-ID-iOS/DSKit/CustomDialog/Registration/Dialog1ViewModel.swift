//
//  Dialog1ViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/11/24.
//

import Foundation
import SwiftUI
import Combine

enum Dialog1State {
    case hospital
}

class Dialog1ViewModel: BaseViewModel<Dialog1State> {
    @Published var isPresented: Bool = false
    
    init(isPresented: Bool = false) {
        self.isPresented = isPresented
    }
    
    func closeDialog() {
        withAnimation {
            isPresented = false
        }
    }
    
    func onHospitalSearchButtonTapped() {
            print("병원 알아보기 버튼 클릭")
            // 병원 검색 화면 또는 특정 작업 처리
        }
}
