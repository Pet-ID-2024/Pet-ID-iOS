//import Moya
//import Combine
//
//enum PetInfoState {
//    case back
//    case valid
//    case invalid
//}
//
//class PetInfoViewModel: BaseViewModel<PetInfoState> {
//    
//    @Published var name: String = ""
//    @Published var birthDate: String = ""
//    @Published var showDatePicker: Bool = false
//    @Published var selectedDate: Date = Date()
//    @Published var gender: String = ""
//    @Published var neuteringDate: String = ""
//    @Published var isNextScreenPresented: Bool = false
//    @Published var neuteredChecked: Bool = false
//    @Published var isNextButtonDisabled: Bool = true
//    
//    var temporaryData: [String: Any]
//    
//    init(temporaryData: [String: Any]) {
//        self.temporaryData = temporaryData
//        super.init()
//        loadTemporaryData()
//    }
//    
//    enum Field: Hashable {
//        case name, birthDate, neuteringDate, gender, address, phone, detailAddress
//    }
//    
//    @Published var focusedField: Field?
//    
//    private var dateFormatter: DateFormatter {
//        return DateFormatter.petInfoDateFormatter
//    }
//    
//    private func loadTemporaryData() {
//        if let savedName = temporaryData["petName"] as? String {
//            name = savedName
//        }
//        if let savedBirthDate = temporaryData["petBirthDate"] as? String {
//            birthDate = savedBirthDate
//        }
//        if let savedGender = temporaryData["petSex"] as? String {
//            gender = savedGender
//        }
//        if let savedNeuteringDate = temporaryData["petNeuteredDate"] as? String {
//            neuteringDate = savedNeuteringDate
//        }
//        if let savedNeuteredChecked = temporaryData["petNeuteredYn"] as? Bool {
//            neuteredChecked = savedNeuteredChecked
//        }
//        Logger().debug("✅ 임시 저장 데이터 로드 완료: \(temporaryData)")
//    }
//    
//    func toggleNeuteredChecked() {
//        neuteredChecked.toggle()
//        validateInput()
//    }
//    
//    func updateBirthDate(with date: Date) {
//        birthDate = dateFormatter.string(from: date)
//        showDatePicker = false
//        validateInput()
//    }
//    
//    func updateNeuteringDate(with date: Date) {
//        neuteringDate = dateFormatter.string(from: date)
//        showDatePicker = false
//        validateInput()
//    }
//    
//    func navigateToPetCaption() {
//        result.send(.valid)
//    }
//    
//    func navigateBack() {
//        result.send(.back)
//    }
//    
//    func validateInput() {
//        let isNameValid = !name.isEmpty
//        let isBirthDateValid = !birthDate.isEmpty
//        let isGenderValid = !gender.isEmpty
//        
//        // 중성화 여부에 따라 중성화 날짜 필수 여부 결정
//        let isNeuteringDateValid = !neuteringDate.isEmpty
//        // 중성화 전 체크박스가 체크되면 중성화 날짜는 필수 아님
//        let isNeuteredCheckedValid = neuteredChecked ? true : isNeuteringDateValid
//        
//        // 모든 필수 항목이 만족되면 isValid가 true
//        let isValid = isNameValid && isBirthDateValid && isGenderValid && isNeuteredCheckedValid
//        
//        // 버튼 활성화 여부 설정
//        isNextButtonDisabled = !isValid
//    }
//    
//    func handleNextButtonTapped() {
//        validateInput()
//        if !isNextButtonDisabled {
//            let convertedGender = (gender == "남") ? "M" : "F"
//            let petInfo: [String: Any] = [
//                "petName": name,
//                "petBirthDate": birthDate,
//                "petSex": convertedGender,
//                "petNeuteredYn": neuteredChecked ? "N" : "Y",
//                "petNeuteredDate": neuteredChecked ? "nil" : neuteringDate
//            ]
//            temporaryData["petInfo"] = petInfo
//            Logger().debug("✅ 저장된 반려동물 정보: \(temporaryData)")
//            result.send(.valid)
//        }
//    }
//}

import Moya
import Combine

enum PetInfoState {
    case back
    case valid
    case invalid
}

class PetInfoViewModel: BaseViewModel<PetInfoState> {
    
    @Published var name: String = ""
    @Published var birthDate: String = ""
    @Published var showDatePicker: Bool = false
    @Published var selectedDate: Date = Date()
    @Published var gender: String = ""
    @Published var neuteringDate: String = ""
    @Published var isNextScreenPresented: Bool = false
    @Published var neuteredChecked: Bool = false
    @Published var isNextButtonDisabled: Bool = true
    
    var temporaryData: [String: Any]
    
    init(temporaryData: [String: Any]) {
        self.temporaryData = temporaryData
        super.init()
        loadTemporaryData()
    }
    
    private var dateFormatter: DateFormatter {
        return DateFormatter.petInfoDateFormatter
    }
    
    private func loadTemporaryData() {
        if let savedName = temporaryData["petName"] as? String {
            name = savedName
        }
        if let savedBirthDate = temporaryData["petBirthDate"] as? String {
            birthDate = savedBirthDate
        }
        if let savedGender = temporaryData["petSex"] as? String {
            gender = savedGender
        }
        if let savedNeuteringDate = temporaryData["petNeuteredDate"] as? String {
            neuteringDate = savedNeuteringDate
        }
        if let savedNeuteredChecked = temporaryData["petNeuteredYn"] as? Bool {
            neuteredChecked = savedNeuteredChecked
        }
        Logger().debug("✅ 임시 저장 데이터 로드 완료: \(temporaryData)")
    }
    
    func toggleNeuteredChecked() {
        neuteredChecked.toggle()
        validateInput()
    }
    
    func updateBirthDate(with date: Date) {
        birthDate = dateFormatter.string(from: date)
        showDatePicker = false
        validateInput()
    }
    
    func updateNeuteringDate(with date: Date) {
        neuteringDate = dateFormatter.string(from: date)
        showDatePicker = false
        validateInput()
    }
    
    func navigateToPetCaption() {
        result.send(.valid)
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func validateInput() {
        let isNameValid = !name.isEmpty
        let isBirthDateValid = !birthDate.isEmpty
        let isGenderValid = !gender.isEmpty
        
        // 중성화 여부에 따라 중성화 날짜 필수 여부 결정
        let isNeuteringDateValid = !neuteringDate.isEmpty
        let isNeuteredCheckedValid = neuteredChecked ? true : isNeuteringDateValid
        
        // 모든 필수 항목이 만족되면 isValid가 true
        let isValid = isNameValid && isBirthDateValid && isGenderValid && isNeuteredCheckedValid
        
        // 버튼 활성화 여부 설정
        isNextButtonDisabled = !isValid
    }
    
    func handleNextButtonTapped() {
        validateInput()
        if !isNextButtonDisabled {
            let convertedGender = (gender == "남") ? "M" : "F"
            let petInfo: [String: Any] = [
                "petName": name,
                "petBirthDate": birthDate,
                "petSex": convertedGender,
                "petNeuteredYn": neuteredChecked ? "N" : "Y",
                "petNeuteredDate": neuteredChecked ? "nil" : neuteringDate
            ]
            temporaryData["petInfo"] = petInfo
            Logger().debug("✅ 저장된 반려동물 정보: \(temporaryData)")
            result.send(.valid)
        }
    }
}
