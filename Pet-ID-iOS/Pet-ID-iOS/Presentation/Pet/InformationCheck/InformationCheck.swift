//
//  Complete.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/11/24.
//

import SwiftUI

struct InformationCheck: View {
    @StateObject var viewModel: InformationCheckViewModel
    var coordinator: InformationCheckCoordinator
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        viewModel.navigateBack()
                    }) {
                        DSImage.chevronicon.toImage()
                            .font(.petIdChevron)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                
                
                VStack(alignment: .leading, spacing: 10){
                    Text("6/7")
                        .font(.petIdTitle2)
                        .foregroundColor(.petid_clearblue)
                    
                    Text("아래 내용으로 \n펫 아이디를 만들게요")
                        .font(.petIdTitle1)
                    
                    Text("실제 정보와 다를 시 반려동물 등록을 할 수 없어요")
                        .foregroundColor(.petid_gray)
                }
                .padding()
                
                Spacer()
                
                VStack(alignment: .leading){
                    Text("펫아이디 정보")
                        .font(.petIdBody2)
                        .foregroundColor(.petid_gray)
                    VStack(alignment: .leading, spacing: 10) {
                        
                        DetailInfoView(label: "이름", value: "코코")
                        DetailInfoView(label: "생일", value: "2022.03.02")
                        DetailInfoView(label: "성별", value: "여, 중성화x")
                        DetailInfoView(label: "품종", value: "말티즈")
                        DetailInfoView(label: "특징", value: "흰색, 곱슬, 장모")
                        DetailInfoView(label: "몸무게", value: "4kg")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button {
                        viewModel.navigateToSign()
                    } label: {
                        Text("다음")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_clearblue)
                            .foregroundColor(.petid_white)
                            .cornerRadius(8)
                    }
                
                }
                .padding()
                
                Spacer()
                
            }
        }
        .padding()
    }
}

#Preview {
    InformationCheck(viewModel: InformationCheckViewModel(), coordinator: InformationCheckCoordinator(navigationController: UINavigationController()))
}

struct DetailInfoView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.petIdBody2)
                .foregroundColor(.petid_gray)
            Spacer()
            Text(value)
                .font(.petIdBody2)
        }
        .padding(.vertical, 2)
    }
}
