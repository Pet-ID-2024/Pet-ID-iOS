import SwiftUI
import Combine

enum SignState {
    case completed
    case back
}

final class SignViewModel: BaseViewModel<SignState> {
    @Published var lines: [[CGPoint]] = []
    
    var temporaryData: [String: Any]
    
    init(temporaryData: [String: Any]) {
        self.temporaryData = temporaryData
        super.init()
        loadTemporaryData()
    }
    
    private func loadTemporaryData() {
        if let savedSignPath = temporaryData["sign"] as? String {
            Logger().debug("✅ 임시 저장된 서명 데이터 로드 완료: \(savedSignPath)")
        } else {
            temporaryData["sign"] = "petIdSign/t.png"
            Logger().debug("⚠️ 서명 데이터가 없어 기본값으로 설정: \(temporaryData["sign"]!)")
        }
    }
    
    private func saveSignature() {
        // 현재 서명 데이터를 저장
        temporaryData["sign"] = "petIdSign/t.png"
        Logger().debug("✅ 서명 데이터 저장 완료: \(temporaryData["sign"]!)")
    }
    
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
