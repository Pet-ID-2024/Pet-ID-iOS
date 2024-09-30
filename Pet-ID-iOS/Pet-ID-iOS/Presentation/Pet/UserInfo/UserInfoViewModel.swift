//
//  UserInfoViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/4/24.
//

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
//    private var memberService: MemberService
    
    init(/*memberService: MemberService, */user: UserModel = UserModel(name: "", phoneNumber: "", address: "", detailAddress: "")) {
//        self.memberService = memberService
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
    
    func validateInput() {
        let fullAddress = user.address + " " + user.detailAddress
        
        let isValid = !user.name.isEmpty &&
        !user.phoneNumber.isEmpty &&
        user.phoneNumber.allSatisfy({ $0.isNumber }) &&
        !fullAddress.isEmpty
        isNextButtonDisabled = !isValid
//        if isValid {
//            result.send(.valid)
//        } else {
//            result.send(.invalid)
//        }
        isNextButtonDisabled = !isValid
    }
    
//    func saveUserInfo() {
//            memberService.saveMember(name: user.name, address: user.address, phone: user.phoneNumber, receiveAgreement: true) { result in
//                switch result {
//                case .success(let response):
//                    print("회원 정보 저장 성공: \(response)")
//                    self.result.send(.valid) // 다음 화면으로 이동
//                case .failure(let error):
//                    print("회원 정보 저장 실패: \(error.localizedDescription)")
//                    self.result.send(.invalid) // 유효성 검증 실패 처리
//                }
//            }
//        }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func handleNextButtonTapped() {
            validateInput() // 유효성 검사 실행
            if !isNextButtonDisabled {
                result.send(.valid) // 다음 페이지로 이동
//                saveUserInfo()
            }
        }
    
//    func navigateToPetInfo() {
//        result.send(.next)
//    }
    
}


//class MemberService {
//    private let provider = MoyaProvider<MemberAPI>()
//
//    var headers: [String: String]? {
//        do {
//            let authorization: Authorization = try DefaultAuthRepository().fetchAuthTokensFromKeychainSync()
//            print("Fetched access token: \(authorization.accessToken)")
//            return ["Authorization": "\(authorization.accessToken)", "Content-Type": "application/json"]
//        } catch {
//            print("Error fetching access token: \(error)")
//            return nil
//        }
//    }
//
//    func saveMember(name: String, address: String, phone: String, receiveAgreement: Bool, completion: @escaping (Result<SaveMemberResponse, Error>) -> Void) {
//        let parameters: [String: Any] = [
//            "name": name,
//            "address": address,
//            "phone": phone,
//            "receiveAgreement": receiveAgreement
//        ]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
//
//        // Request Headers and Body Log
//        print("Request Headers: \(headers ?? [:])")
//        if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
//            print("Request Body: \(jsonString)")
//        }
//
//        provider.request(.saveMember(name: name, address: address, phone: phone, receiveAgreement: receiveAgreement)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let decoder = JSONDecoder()
//                    let saveResponse = try decoder.decode(SaveMemberResponse.self, from: response.data)
//                    completion(.success(saveResponse))
//                } catch {
//                    completion(.failure(error))
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
