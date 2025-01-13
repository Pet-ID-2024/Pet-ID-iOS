import SwiftUI
import Combine
import Moya

enum UserInfoState {
    case valid
    case invalid
    case back
}

class UserInfoViewModel: BaseViewModel<UserInfoState> {
    @Published var user: UserModel
    @Published var isNextButtonDisabled: Bool = true
    @Published var isSameAddress: Bool = false
    
    var temporaryData: [String: Any]
    
    init(temporaryData: [String: Any], user: UserModel = UserModel(name: "", phoneNumber: "", address: "", detailAddress: "", rra: "", rraDetails: "")) {
        self.temporaryData = temporaryData
        self.user = user
        super.init()
        loadTemporaryData()
        validateInput()
    }
    
    // 임시 저장된 데이터 로드
    private func loadTemporaryData() {
        user.name = temporaryData["name"] as? String ?? ""
        user.phoneNumber = temporaryData["phoneNumber"] as? String ?? ""
        user.address = temporaryData["address"] as? String ?? ""
        user.detailAddress = temporaryData["detailAddress"] as? String ?? ""
        user.rra = temporaryData["rra"] as? String ?? ""
        user.rraDetails = temporaryData["rraDetails"] as? String ?? ""
        user.isSameAddress = temporaryData["isSameAddress"] as? Bool ?? false
        Logger().debug("✅ 임시 저장 데이터 로드 완료: \(temporaryData)")
    }
    
    // 유저 이름 업데이트
    func updateName(_ newName: String) {
        let filtered = newName.filter { $0.isLetter }
        guard filtered != user.name else { return }
        user.name = filtered
        temporaryData["name"] = filtered
        validateInput()
    }
    
    // 유저 전화번호 업데이트
    func updatePhoneNumber(_ newPhoneNumber: String) {
        // 숫자만 추출하고 11자리로 제한
        let digits = newPhoneNumber.filter { $0.isNumber }
        let limitedDigits = String(digits.prefix(11)) // 11자리까지만 허용
        
        let formattedPhoneNumber = formatPhoneNumber(limitedDigits) // 포맷팅된 번호
        guard formattedPhoneNumber != user.phoneNumber else { return } // 동일하면 반환
        
        user.phoneNumber = formattedPhoneNumber
        temporaryData["phoneNumber"] = formattedPhoneNumber
        validateInput()
    }
    
    // 유저 주소 업데이트
    func updateAddress(_ newAddress: String) {
        guard newAddress != user.address else { return }
        user.address = newAddress
        temporaryData["address"] = newAddress
        if isSameAddress {
                handleAddressSync()
            }
        validateInput()
    }
    
    // 유저 상세 주소 업데이트
    func updateDetailAddress(_ newDetailAddress: String) {
        guard newDetailAddress != user.detailAddress else { return }
        user.detailAddress = newDetailAddress
        temporaryData["detailAddress"] = newDetailAddress
        if isSameAddress {
                handleAddressSync()
            }
        validateInput()
    }
    
    // 주민등록 주소 업데이트
    func updateRra(_ newRra: String) {
        guard newRra != user.rra else { return }
        user.rra = newRra
        temporaryData["rra"] = newRra
        validateInput()
    }
    
    // 주민등록 상세 주소 업데이트
    func updateRraDetails(_ newRraDetails: String) {
        guard newRraDetails != user.rraDetails else { return }
        user.rraDetails = newRraDetails
        temporaryData["rraDetails"] = newRraDetails
        validateInput()
    }
    
    // 주소 동기화 처리
    func handleAddressSync() {
        if isSameAddress {
            // isSameAddress가 true일 때만 동기화
            if user.address != user.rra {
                user.rra = user.address
                user.rraDetails = user.detailAddress
                temporaryData["rra"] = user.address
                temporaryData["rraDetails"] = user.detailAddress
            }
        } else {
            // isSameAddress가 false일 때 초기화
            if !user.rra.isEmpty || !user.rraDetails.isEmpty {
                user.rra = ""
                user.rraDetails = ""
                temporaryData["rra"] = ""
                temporaryData["rraDetails"] = ""
            }
        }
        validateInput()
        Logger().debug("✅ 주소 동기화 처리 완료: \(user)")
    }
    
    // 입력 값 유효성 검사
    func validateInput() {
        let cleanedPhoneNumber = user.phoneNumber.replacingOccurrences(of: "-", with: "")
        let isAddressValid = !user.address.isEmpty && !user.detailAddress.isEmpty
        let isValid = !user.name.isEmpty && cleanedPhoneNumber.count == 11 && cleanedPhoneNumber.allSatisfy { $0.isNumber } && isAddressValid
        isNextButtonDisabled = !isValid
    }
    
    // 이전 화면으로 이동
    func navigateBack() {
        result.send(.back)
    }
    
    // 다음 버튼 동작 처리
    func handleNextButtonTapped() {
        validateInput()
        if !isNextButtonDisabled {
            Logger().debug("✅ 유효한 입력 데이터: \(user)")
            let proposer = ProposerRequestDTO(
                name: user.name,
                address: user.address,
                addressDetails: user.detailAddress,
                rra: user.rra,
                rraDetails: user.rraDetails,
                phone: user.phoneNumber
            )
            temporaryData["proposer"] = proposer
            Logger().debug("✅ 저장된 임시 데이터: \(temporaryData)")
            result.send(.valid)
        } else {
            Logger().error("❌ 입력 데이터가 유효하지 않습니다.")
            result.send(.invalid)
        }
    }
    
    // 전화번호 포맷팅
    private func formatPhoneNumber(_ number: String) -> String {
        let cleanedNumber = number.filter { $0.isNumber } // 숫자만 필터링
        guard cleanedNumber.count == 11 else { return cleanedNumber } // 11자리가 아니면 반환
        let areaCode = cleanedNumber.prefix(3) // 앞 3자리
        let centralOfficeCode = cleanedNumber.dropFirst(3).prefix(4) // 중간 4자리
        let lineNumber = cleanedNumber.suffix(4) // 마지막 4자리
        return "\(areaCode)-\(centralOfficeCode)-\(lineNumber)" // 형식화된 문자열 반환
    }
}
