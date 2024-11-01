import Foundation
import SwiftUI

enum ScanCheckState {
//    case completed
    case next
    case back
}

class ScanCheckViewModel: BaseViewModel<ScanCheckState> {
    
    @Published var productType: String = ""
    @Published var furColor: String = ""
    @Published var furFeatures: String = ""
    @Published var bodyWeight: String = ""
    
    private let image: UIImage
    
    
    init(image: UIImage) {
        self.image = image
        super.init()
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func navigateToIC() {
        result.send(.next)
    }
}
