//
//  PetInfoViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/31/24.
//

import Moya
import Combine

enum PetInfoViewModelResult {
    case petCaption
    case back
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
    @Published var phone: String = ""
    @Published var address: String = ""
    
    enum Field: Hashable {
        case name, birthDate, neuteringDate, gender, address, phone
    }
    
    @Published var focusedField: Field?
    
    private var dateFormatter: DateFormatter {
        return DateFormatter.petInfoDateFormatter
    }
    
    func toggleNeuteredChecked() {
        neuteredChecked.toggle()
    }
    
    func updateBirthDate(with date: Date) {
        birthDate = dateFormatter.string(from: date)
        showDatePicker = false
    }
    
    func updateNeuteringDate(with date: Date) {
        neuteringDate = dateFormatter.string(from: date)
        showDatePicker = false
    }
    
    func navigateToPetCaption() {
        result.send(.petCaption)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
