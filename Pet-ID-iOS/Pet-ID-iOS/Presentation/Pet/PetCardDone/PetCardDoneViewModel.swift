import SwiftUI
import Combine

enum PetCardDoneState {
    case done
    case back
}

class PetCardDoneViewModel: BaseViewModel<PetCardDoneState> {
    func navigateBack() {
        result.send(.back)
    }
    
    func complete() {
        result.send(.done)
    }
}

