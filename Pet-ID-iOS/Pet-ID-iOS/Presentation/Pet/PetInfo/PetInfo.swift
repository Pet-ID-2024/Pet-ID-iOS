//
//  UserInfo.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 9/30/24.
//

import SwiftUI

struct PetInfo: View {
    @ObservedObject var viewModel: PetInfoViewModel
    var coordinator: PetInfoCoordinator?
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: {
                    viewModel.navigateBack()
                }) {
                    DSImage.chevronicon.toImage()
                        .font(.title)
                        .foregroundColor(.petid_title)
                }
                Spacer()
            }
            //            .padding()
            
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 10){
                    Text("3/7")
                        .font(.body1_bold)
                        .foregroundColor(.petid_clearblue)
                    
                    Text("반려동물의 정보를 \n알려주세요")
                        .font(.headline1)
                        .lineLimit(nil)
                }
                Spacer()
                
                
                VStack(spacing: 30){
                    CustomField(
                        text: $viewModel.name,
                        field: .name,
                        placeholder: "이름",
                        label: "반려동물이름",
                        inputType: .text
                    )
                    .onChange(of: viewModel.name) { _ in viewModel.validateInput() }
                    
                    CustomField(
                        text: $viewModel.birthDate,
                        field: .birthDate,
                        placeholder: "생년월일 선택",
                        label: "생년월일",
                        inputType: .date
                    )
                    .onChange(of: viewModel.birthDate) { _ in viewModel.validateInput() }
                    
                    
                    GenderField(
                        gender: $viewModel.gender,
                        focusedField: $viewModel.focusedField
                    )
                    .onChange(of: viewModel.gender) { _ in viewModel.validateInput() }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        CustomField(
                            text: $viewModel.neuteringDate,
                            field: .neuteringDate,
                            placeholder: "중성화 날짜 선택",
                            label: "중성화 날짜",
                            inputType: .date
                        )
                        .onChange(of: viewModel.neuteringDate) { _ in viewModel.validateInput() }
                        
                        HStack {
                            CheckBox(isChecked: $viewModel.neuteredChecked)
                                .onChange(of: viewModel.neuteredChecked) { _ in viewModel.validateInput() }
                            Text("중성화 전이에요.")
                                .font(.caption1_med)
                                .fontWeight(.medium)
                                .foregroundColor(.petid_gray)
                        }
                    }
                    
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.handleNextButtonTapped()
                    //                    viewModel.saveUserInfo()
                    if !viewModel.isNextButtonDisabled {
                        //                            coordinator.navigateToPetInfo()
                    }
                    
                }) {
                    Text("다음")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isNextButtonDisabled ? Color.petid_b9 : Color.petid_clearblue)
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

#Preview {
    PetInfo(viewModel: PetInfoViewModel(temporaryData: [:]))
}
