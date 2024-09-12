//
//  UserInfo.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/4/24.
//

import SwiftUI

struct UserInfo: View {
    @ObservedObject var viewModel: UserInfoViewModel
    var coordinator: UserInfoCoordinator
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button {
                    coordinator.navigateBack()
                } label: {
                    DSImage.chevronicon.toImage()
                        .font(.petIdChevron)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 10){
                    Text("2/7")
                        .font(.petIdTitle1)
                        .foregroundColor(.petid_clearblue)
                    
                    Text("회원님의 정보를 \n알려주세요")
                        .font(.petIdTitle1)
                }
                Spacer()
                
                
                VStack(spacing: 30){
                    CustomField(
                        text: $viewModel.user.name,
                        field: .name,
                        placeholder: "이름을 입력해 주세요.",
                        label: "이름",
                        inputType: .text
                    )
                    .onChange(of: viewModel.user.name) { newValue in
                        viewModel.updateName(newValue)
                    }
                    
                    CustomField(
                        text: $viewModel.user.phoneNumber,
                        field: .phone,
                        placeholder: "숫자만 입력해 주세요.",
                        label: "휴대폰 번호",
                        inputType: .phoneNumber
                    )
                    .onChange(of: viewModel.user.phoneNumber) { newValue in
                        viewModel.updatePhoneNumber(newValue)
                    }
                    
                    VStack{
                        CustomField(
                            text: $viewModel.user.address,
                            field: .address,
                            placeholder: "주소를 입력해 주세요.",
                            label: "주소",
                            inputType: .address
                        )
                        .onChange(of: viewModel.user.address) { newValue in
                            viewModel.updateAddress(newValue)
                        }
                        
                        CustomField(text: $viewModel.user.detailAddress, field: .detailAddress, placeholder: "상세주소를 입력해 주세요", label: "", inputType: .detailAddress)
                            .padding(.top, -20)
                            .onChange(of: viewModel.user.detailAddress) { newValue in
                                viewModel.updateDetailAddress(newValue)
                            }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    if !viewModel.isNextButtonDisabled {
                        viewModel.validateInput()
                    }
                }) {
                    Text("다음")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isNextButtonDisabled ? Color.gray : Color.blue)
                        .cornerRadius(8)
                        .disabled(viewModel.isNextButtonDisabled)
                }
                .padding(.bottom)
            }
            .padding()
            .navigationBarHidden(true)
        }
        .padding()
        .onAppear {
            viewModel.validateInput()
        }
    }
}

#Preview{
    UserInfo(viewModel: UserInfoViewModel(), coordinator: UserInfoCoordinator(navigationController: UINavigationController()))
}

