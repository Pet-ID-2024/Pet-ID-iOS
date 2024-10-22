////
////  UserInfoEdit.swift
////  Pet-ID-iOS
////
////  Created by 박호건 on 10/9/24.
////
//
//import SwiftUI
//
//struct UserInfoEdit: View {
//    var body: some View {
//        VStack(alignment: .leading){
//            HStack {
//                Button(action: {
//                    //                    coordinator.navigateBack()
//                }) {
//                    DSImage.chevronicon.toImage()
//                        .font(.title2)
//                        .foregroundColor(.petid_title)
//                }
//                Spacer()
//                
//                Text("내 정보")
//                
//                Spacer()
//            }
//            
//            VStack(spacing: 30){
//                CustomField(
//                    text: $viewModel.user.name,
//                    field: .name,
//                    placeholder: "이름을 입력해 주세요.",
//                    label: "이름",
//                    inputType: .text
//                )
//                .onChange(of: viewModel.user.name) { newValue in
//                    viewModel.updateName(newValue)
//                }
//                
//                CustomField(
//                    text: $viewModel.user.phoneNumber,
//                    field: .phone,
//                    placeholder: "숫자만 입력해 주세요.",
//                    label: "휴대폰 번호",
//                    inputType: .phoneNumber
//                )
//                .onChange(of: viewModel.user.phoneNumber) { newValue in
//                    viewModel.updatePhoneNumber(newValue)
//                }
//                
//                VStack{
//                    CustomField(
//                        text: $viewModel.user.address,
//                        field: .address,
//                        placeholder: "주소를 입력해 주세요.",
//                        label: "주소",
//                        inputType: .address
//                    )
//                    .onChange(of: viewModel.user.address) { newValue in
//                        viewModel.updateAddress(newValue)
//                    }
//                    
//                    CustomField(text: $viewModel.user.detailAddress, field: .detailAddress, placeholder: "상세주소를 입력해 주세요", label: "", inputType: .detailAddress)
//                        .padding(.top, -20)
//                        .onChange(of: viewModel.user.detailAddress) { newValue in
//                            viewModel.updateDetailAddress(newValue)
//                        }
//                    
//                }
//            }
//        }
//        .padding()
//    }
//    
//    
//}
//
//#Preview {
//    UserInfoEdit()
//}
