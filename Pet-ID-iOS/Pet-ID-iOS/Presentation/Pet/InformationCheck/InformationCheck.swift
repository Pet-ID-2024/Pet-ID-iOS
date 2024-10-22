//
//  InformationCheck.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/1/24.
//

import SwiftUI

struct InformationCheck: View {
    @ObservedObject var viewModel: InformationCheckViewModel
    var coordinator: InformationCoordinator?
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
            
            VStack(alignment: .leading, spacing: 10){
                Text("6/7")
                    .font(.body1_bold)
                    .foregroundColor(.petid_clearblue)
                
                Text("아래 내용으로 \n펫 아이디를 만들게요")
                    .font(.headline1)
                
                Text("실제 정보와 다를 시 반려동물 등록을 할 수 없어요")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
            }
            .padding()
            
            Spacer()
            
            VStack(alignment: .leading){
                Text("펫아이디 정보")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
                VStack(alignment: .leading, spacing: 25) {
                    
                    DetailInfoView(label: "이름", value: "코코")
                    DetailInfoView(label: "생일", value: "2022.03.02")
                    DetailInfoView(label: "성별", value: "여, 중성화x")
                    DetailInfoView(label: "품종", value: "말티즈")
                    DetailInfoView(label: "특징", value: "흰색, 곱슬, 장모")
                    DetailInfoView(label: "몸무게", value: "4kg")
                }
                .padding()
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(Color.petid_fa)
                .cornerRadius(10)
            }
            .padding()
            .padding(.top, -80)
                
                Spacer()
                
                Button {
                    viewModel.navigateToSign()
                } label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .font(.body2_med)
                        .padding()
                        .background(Color.petid_clearblue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            
            
        }
        .padding()
    }
}

#Preview {
    InformationCheck(viewModel: InformationCheckViewModel())
}

struct DetailInfoView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.body3_med)
                .foregroundColor(.petid_gray)
            Spacer()
            Text(value)
                .font(.body3_med)
        }
        .padding(.vertical, 2)
    }
}
