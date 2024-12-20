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
    var temporaryData: [String: Any]
    
    
    init(image: UIImage = UIImage(named: "placeholder") ?? UIImage(), temporaryData: [String: Any]) {
        self.image = image
        self.temporaryData = temporaryData
        super.init()
        loadTemporaryData()
    }
    
    private func loadTemporaryData() {
        if let productType = temporaryData["productType"] as? String {
            self.productType = productType
        }
        if let furColor = temporaryData["furColor"] as? String {
            self.furColor = furColor
        }
        if let furFeatures = temporaryData["furFeatures"] as? String {
            self.furFeatures = furFeatures
        }
        if let bodyWeight = temporaryData["bodyWeight"] as? String {
            self.bodyWeight = bodyWeight
        }
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func navigateToIC() {
        result.send(.next)
    }
}
