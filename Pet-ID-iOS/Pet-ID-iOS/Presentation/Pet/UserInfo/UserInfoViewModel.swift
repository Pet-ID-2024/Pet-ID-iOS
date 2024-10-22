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
    
    init(user: UserModel = UserModel(name: "", phoneNumber: "", address: "", detailAddress: "")) {
        self.user = user
        super.init()
        validateInput()
    }
    
    func updateName(_ newName: String) {
        let filtered = newName.filter { $0.isLetter }
        if filtered != user.name {
            user.name = filtered
            validateInput()
        }
    }
    
    func updatePhoneNumber(_ newPhoneNumber: String) {
        let formattedPhoneNumber = formatPhoneNumber(newPhoneNumber)
        user.phoneNumber = formattedPhoneNumber
        validateInput()
    }
    
    private func formatPhoneNumber(_ number: String) -> String {
        let cleanedNumber = number.replacingOccurrences(of: "-", with: "") // 기존 하이픈 제거
        guard cleanedNumber.count == 11 else { return cleanedNumber } // 11자리 전화번호인지 확인
        
        let areaCode = cleanedNumber.prefix(3)
        let centralOfficeCode = cleanedNumber[cleanedNumber.index(cleanedNumber.startIndex, offsetBy: 3)..<cleanedNumber.index(cleanedNumber.startIndex, offsetBy: 7)]
        let lineNumber = cleanedNumber.suffix(4)
        
        return "\(areaCode)-\(centralOfficeCode)-\(lineNumber)" // 하이픈 추가 후 반환
    }
    
    func updateAddress(_ newAddress: String) {
        user.address = newAddress
        validateInput()
    }
    
    func updateDetailAddress(_ newDetailAddress: String) {
        user.detailAddress = newDetailAddress
        validateInput()
    }
    
//    func validateInput() {
//        let fullAddress = user.address + " " + user.detailAddress
//        
//        let isValid = !user.name.isEmpty &&
//        !user.phoneNumber.isEmpty &&
//        user.phoneNumber.allSatisfy({ $0.isNumber }) &&
//        !fullAddress.isEmpty
//        isNextButtonDisabled = !isValid
//        //        if isValid {
//        //            result.send(.valid)
//        //        } else {
//        //            result.send(.invalid)
//        //        }
//        //        isNextButtonDisabled = !isValid
//    }

    func validateInput() {
        // 전화번호의 숫자만 포함되었는지 확인
        let cleanedPhoneNumber = user.phoneNumber.replacingOccurrences(of: "-", with: "")
        
        // 주소와 세부 주소를 합쳐서 하나의 주소로 만듦
        let isAddressValid = !user.address.isEmpty && !user.detailAddress.isEmpty
        
        // 이름, 전화번호, 주소가 모두 유효한지 확인
        let isValid = !user.name.isEmpty &&
                      cleanedPhoneNumber.count == 11 && // 11자리인지 확인
                      cleanedPhoneNumber.allSatisfy({ $0.isNumber }) && // 숫자로만 이루어져 있는지 확인
                      isAddressValid
        
        // 버튼 활성화/비활성화 설정
        isNextButtonDisabled = !isValid
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func handleNextButtonTapped() {
        validateInput() // 유효성 검사 실행
        if !isNextButtonDisabled {
            result.send(.valid) // 다음 페이지로 이동
        }
    }
}
