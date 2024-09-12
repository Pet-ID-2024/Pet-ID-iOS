import Moya
import Combine

enum PetInfoViewModelResult {
    case back
    case valid
    case invalid
}

class PetInfoViewModel: BaseViewModel<PetInfoViewModelResult> {
    
    @Published var name: String = ""
    @Published var birthDate: String = ""
    @Published var showDatePicker: Bool = false
    @Published var selectedDate: Date = Date()
    @Published var gender: String = ""
    @Published var neuteringDate: String = ""
    @Published var isNextScreenPresented: Bool = false
    @Published var neuteredChecked: Bool = false
    @Published var isNextButtonDisabled: Bool = true
    
    enum Field: Hashable {
        case name, birthDate, neuteringDate, gender, address, phone, detailAddress
    }
    
    @Published var focusedField: Field?
    
    private var dateFormatter: DateFormatter {
        return DateFormatter.petInfoDateFormatter
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
        let isNeuteringDateValid = !neuteringDate.isEmpty
        let isNeuteredCheckedValid = !neuteredChecked || isNeuteringDateValid
        
        let isValid = isNameValid &&
        isBirthDateValid &&
        isGenderValid &&
        isNeuteredCheckedValid
        
        isNextButtonDisabled = !isValid
        if isValid {
            result.send(.valid)
        } else {
            result.send(.invalid)
        }
    }
}
