import SwiftUI
import Combine

enum ReservationDoneState {
    case done
    case back
}

class ReservationDoneViewModel: BaseViewModel<ReservationDoneState> {
    func navigateBack() {
        result.send(.back)
    }
    
    func complete() {
        result.send(.done)
    }
}
