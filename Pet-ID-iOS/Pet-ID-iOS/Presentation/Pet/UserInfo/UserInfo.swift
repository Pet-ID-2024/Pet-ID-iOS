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
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            
            Text("2/7")
                .font(.petIdTitle1)
                .foregroundColor(.petid_clearblue)
            
            Text("회원님의 정보를 \n알려주세요")
                .font(.petIdTitle1)
            
            
            
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
            
            CustomField(
                text: $viewModel.user.detailAddress,
                field: .address,
                placeholder: "상세주소를 입력해 주세요.",
                label: "상세주소",
                inputType: .text
            )
            .onChange(of: viewModel.user.detailAddress) { newValue in
                viewModel.updateDetailAddress(newValue)
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
        .onAppear {
            viewModel.validateInput()
        }
    }
}

#Preview{
    UserInfo(viewModel: UserInfoViewModel(), coordinator: UserInfoCoordinator(navigationController: UINavigationController()))
}

