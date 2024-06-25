//
//  UserInfo.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/4/24.
//

import SwiftUI

struct UserInfo: View {
    @State private var name: String = ""
    @State private var registrationNumberFirstPart: String = ""
    @State private var registrationNumberSecondPart: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var detailAddress: String = ""
    @State private var isNextButtonActive = false
    @State private var isNextButtonDisabled = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                Text("회원님의 정보를 알려주세요")
                    .font(.title)
                    .padding(.top)
                
                Text("펫 아이디 회원은 누구나 서비스를 제공받을 수 있습니다.")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Group {
                    Text("이름")
                    TextField("이름을 입력해 주세요.", text: $name)
                        .padding()
                        .cornerRadius(8)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        .onChange(of: name) { newValue in
                            let filtered = newValue.filter { $0.isLetter }
                            if filtered != newValue {
                                self.name = filtered
                            }
                            validateInput()
                        }
                    Text("생년월일")
                    HStack {
                        TextField("생년월일 6자리", text: $registrationNumberFirstPart)
                            .padding()
                            .cornerRadius(8)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            .keyboardType(.numberPad)
                            .onChange(of: registrationNumberFirstPart) { newValue in
                                validateInput()
                            }
                        
                        Text("-")
                        
                        SecureField("", text: $registrationNumberSecondPart)
                            .padding()
                            .cornerRadius(8)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            .onChange(of: registrationNumberSecondPart) { newValue in
                                validateInput()
                            }
                    }
                    Text("휴대폰 번호")
                    TextField("숫자만 입력해 주세요.", text: $phoneNumber)
                        .padding()
                        .cornerRadius(8)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        .keyboardType(.numberPad)
                        .onChange(of: phoneNumber) { newValue in
                            validateInput()
                        }
                    
                    Text("주소")
                    HStack {
                        TextField("주소를 검색해 주세요.", text: $address)
                            .padding()
                            .cornerRadius(8)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                    }
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    )
                    .onChange(of: address) { newValue in
                        validateInput()
                    }
                    
                    
                    TextField("상세주소를 입력해주세요.", text: $detailAddress)
                        .padding()
                        .cornerRadius(8)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        .onChange(of: detailAddress) { newValue in
                            validateInput()
                        }
                }
                
                Spacer()
                
                
                
                NavigationLink(destination: LoginSuccess(), isActive: $isNextButtonActive) {
                    EmptyView()
                }
                
                Button(action: {
                    if !isNextButtonDisabled {
                        isNextButtonActive = true
                    }
                }) {
                    Text("다음")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isNextButtonDisabled ? Color.gray : Color.blue)
                        .cornerRadius(8)
                        .disabled(isNextButtonDisabled)
                }
                .padding(.bottom)
            }
            .padding()
            
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            validateInput()
        }
    }

    private func validateInput() {
        // 이름이 비어있는지 확인
        if name.isEmpty {
            isNextButtonDisabled = true
            return
        }
        
        // 생년월일 첫 부분이 6자리 숫자인지 확인
        if registrationNumberFirstPart.count != 6 || !registrationNumberFirstPart.allSatisfy({ $0.isNumber }) {
            isNextButtonDisabled = true
            return
        }
        
        // 생년월일 두 번째 부분이 비어있는지 확인
        if registrationNumberSecondPart.isEmpty {
            isNextButtonDisabled = true
            return
        }
        
        // 전화번호가 비어있거나 숫자가 아닌 문자가 있는지 확인
        if phoneNumber.isEmpty || !phoneNumber.allSatisfy({ $0.isNumber }) {
            isNextButtonDisabled = true
            return
        }
        
        // 주소가 비어있는지 확인
        if address.isEmpty {
            isNextButtonDisabled = true
            return
        }
        
        // 모든 검증을 통과하면 버튼을 활성화
        isNextButtonDisabled = false
    }
}



struct UserInfo_Previews: PreviewProvider {
    static var previews: UserInfo {
        UserInfo()
    }
}
