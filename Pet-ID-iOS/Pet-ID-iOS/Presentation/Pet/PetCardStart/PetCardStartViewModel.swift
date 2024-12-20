import Foundation
import Combine

enum PetRegistrationState: String {
    case unregistered
    case externalChip
    case internalChip
    case back
}

final class PetCardStartViewModel: BaseViewModel<PetRegistrationState> {
    @Published var selectedState: PetRegistrationState?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
     var temporaryData: [String: Any] = [:] // 칩 타입 임시 저장용 데이터
    
    // 칩 타입 선택 처리
    func selectChipType(_ chipType: PetRegistrationState) {
        selectedState = chipType
        temporaryData["chipType"] = mapStateToChipType(chipType)
        Logger().debug("✅ 칩 타입 임시 저장: \(mapStateToChipType(chipType))")
    }
    
    // "다음" 버튼 동작 처리
    func handleNextAction() {
        Logger().debug("사용자가 선택한 상태: \(selectedState?.rawValue ?? "선택 없음")")
        
        if let selectedState = selectedState {
            let chipType = mapStateToChipType(selectedState)
            temporaryData["chipType"] = chipType
            Logger().debug("✅ 임시 저장된 칩 타입: \(chipType)")
            result.send(selectedState) // 다음 화면으로 이동
        }
    }
    
    private func mapStateToChipType(_ state: PetRegistrationState) -> String {
        switch state {
        case .unregistered:
            return "NA"
        case .externalChip:
            return "EXTERNAL"
        case .internalChip:
            return "INTERNAL"
        case .back:
            return "NA"
        }
    }
}
