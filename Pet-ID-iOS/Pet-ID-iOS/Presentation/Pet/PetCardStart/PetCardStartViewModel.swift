import Foundation
import Combine

enum PetRegistrationState: String {
    case unregistered
    case externalChip
    case internalChip
    case back
}

class PetCardStartViewModel: BaseViewModel<PetRegistrationState> {
    @Published var selectedState: PetRegistrationState?
    
    func selectState(_ state: PetRegistrationState) {
        self.selectedState = state
        result.send(state)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
