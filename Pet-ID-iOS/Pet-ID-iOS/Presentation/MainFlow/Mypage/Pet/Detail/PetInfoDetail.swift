//
//  UserInfoDetail.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/9/24.
//

import SwiftUI

struct PetInfoDetail: View {
    @ObservedObject var viewModel: PetInfoDetailViewModel
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.navigateBack()
                }) {
                    DSImage.chevronicon.toImage()
                        .font(.title2)
                        .foregroundColor(.petid_title)
                }
                Spacer()
                
                Text("반려동물 정보")
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("수정")
                        .font(.body2_reg)
                        .foregroundColor(.petid_title)
                }

            }
            
            VStack {
                DSImage.randomicon.toImage()
                    .resizable()
                    .frame(width: 88, height: 88)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            
            VStack(spacing: 30) {
                HStack{
                    Text("이름")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("코코")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("생년월일")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("2022.03.02")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("성별")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("여, 중성화X")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("품종")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("말티즈")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("몸무게")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("4kg")
                        .foregroundColor(.petid_subtitle)
                }
                HStack{
                    Text("특징")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("흰색, 곱슬, 장모")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("반려동물 등록")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Button {
                        
                    } label: {
                        HStack{
                            Text("미등록 상태")
                                .underline()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.petid_caution_red)
                    }

                }
                .font(.body2_reg)
            }
            .padding()
            
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    PetInfoDetail(viewModel: PetInfoDetailViewModel())
}
