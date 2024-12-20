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
    
    var temporaryData: [String: Any]
    
    init(temporaryData: [String: Any], user: UserModel = UserModel(name: "", phoneNumber: "", address: "", detailAddress: "")) {
        self.temporaryData = temporaryData
        self.user = user
        super.init()
        loadTemporaryData()
        validateInput()
    }
    
    // 임시 저장된 데이터 로드
    private func loadTemporaryData() {
        if let savedName = temporaryData["name"] as? String {
            user.name = savedName
        }
        if let savedPhoneNumber = temporaryData["phoneNumber"] as? String {
            user.phoneNumber = savedPhoneNumber
        }
        if let savedAddress = temporaryData["address"] as? String {
            user.address = savedAddress
        }
        if let savedDetailAddress = temporaryData["detailAddress"] as? String {
            user.detailAddress = savedDetailAddress
        }
        Logger().debug("✅ 임시 저장 데이터 로드 완료: \(temporaryData)")
    }
    
    // 유저 이름 업데이트
    func updateName(_ newName: String) {
        let filtered = newName.filter { $0.isLetter }
        if filtered != user.name {
            user.name = filtered
            temporaryData["name"] = filtered
            validateInput()
        }
    }
    
    // 유저 전화번호 업데이트
    func updatePhoneNumber(_ newPhoneNumber: String) {
        let formattedPhoneNumber = formatPhoneNumber(newPhoneNumber)
        if formattedPhoneNumber != user.phoneNumber {
            user.phoneNumber = formattedPhoneNumber
            validateInput()
        }
    }
    
    // 유저 주소 업데이트
    func updateAddress(_ newAddress: String) {
        if newAddress != user.address {
            user.address = newAddress
            temporaryData["address"] = newAddress
            validateInput()
        }
    }
    
    // 유저 상세 주소 업데이트
    func updateDetailAddress(_ newDetailAddress: String) {
        if newDetailAddress != user.detailAddress {
            user.detailAddress = newDetailAddress
            temporaryData["detailAddress"] = newDetailAddress
            validateInput()
        }
    }
    
    // 입력 값 유효성 검사
    func validateInput() {
        DispatchQueue.main.async {
            let cleanedPhoneNumber = self.user.phoneNumber.replacingOccurrences(of: "-", with: "")
            let isAddressValid = !self.user.address.isEmpty && !self.user.detailAddress.isEmpty
            
            let isValid = !self.user.name.isEmpty &&
            cleanedPhoneNumber.count == 11 &&
            cleanedPhoneNumber.allSatisfy({ $0.isNumber }) &&
            isAddressValid
            
            self.isNextButtonDisabled = !isValid
        }
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
        let cleanedNumber = number.replacingOccurrences(of: "-", with: "")
        guard cleanedNumber.count == 11 else { return cleanedNumber }
        
        let areaCode = cleanedNumber.prefix(3)
        let centralOfficeCode = cleanedNumber[cleanedNumber.index(cleanedNumber.startIndex, offsetBy: 3)..<cleanedNumber.index(cleanedNumber.startIndex, offsetBy: 7)]
        let lineNumber = cleanedNumber.suffix(4)
        
        return "\(areaCode)-\(centralOfficeCode)-\(lineNumber)"
    }
}
