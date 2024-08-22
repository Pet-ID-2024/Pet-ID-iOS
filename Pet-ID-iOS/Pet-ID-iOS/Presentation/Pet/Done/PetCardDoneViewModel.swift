import SwiftUI
import Combine

enum PetCardDoneResult {
    case done
    case back
}

class PetCardDoneViewModel: BaseViewModel<PetCardDoneResult> {
    func navigateBack() {
        result.send(.back)
    }
    
    func complete() {
        result.send(.done)
    }
}
