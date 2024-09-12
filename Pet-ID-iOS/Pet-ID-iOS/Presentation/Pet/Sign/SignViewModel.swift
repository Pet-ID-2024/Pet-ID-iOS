import SwiftUI
import Combine

enum SignViewModelResult {
    case completed
    case back
}

final class SignViewModel: BaseViewModel<SignViewModelResult> {
    @Published var lines: [[CGPoint]] = []
    
    func navigateToPCD() {
        result.send(.completed)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
