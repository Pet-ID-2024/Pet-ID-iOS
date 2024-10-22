import SwiftUI
import Combine

enum SignState {
    case completed
    case back
}

final class SignViewModel: BaseViewModel<SignState> {
    @Published var lines: [[CGPoint]] = []
    
    func clearButton() {
        lines.removeAll()
    }
    
    func navigateToPCD() {
        result.send(.completed)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
