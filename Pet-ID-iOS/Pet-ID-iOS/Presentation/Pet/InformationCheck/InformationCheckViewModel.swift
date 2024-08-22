import SwiftUI
import Combine

enum InformationCheckViewModelResult {
    case next
    case back
}

class InformationCheckViewModel: BaseViewModel<InformationCheckViewModelResult> {
    @Published var petName: String = "코코"
    @Published var birthDate: String = "2022.03.02"
    @Published var gender: String = "여, 중성화x"
    @Published var breed: String = "말티즈"
    @Published var features: String = "흰색, 곱슬, 장모"
    @Published var weight: String = "4kg"
    
    func navigateToSign() {
        result.send(.next)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
