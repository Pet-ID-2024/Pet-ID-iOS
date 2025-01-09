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
    
    var temporaryData: [String: Any]
    
    init(temporaryData: [String : Any]) {
        self.temporaryData = temporaryData
        super.init()
        loadTemporaryData()
    }
    
    private func loadTemporaryData() {
        if let petImages = temporaryData["petImages"] as? [[String: String]] {
            Logger().debug("✅ 임시 저장된 캡션 데이터 로드 완료: \(petImages)")
        } else {
            Logger().debug("⚠️ 저장된 캡션 데이터가 없습니다.")
        }
    }
    
    func navigateToCamera() {
        result.send(.nextStep)
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func navigateToScan() {
        result.send(.completed)
    }
}
