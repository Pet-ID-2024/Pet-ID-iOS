//
//  Banner.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI

struct Banner: View {
//    @StateObject private var viewModel = BannerViewModel(banner: BannerModel(title: "반려동물과 나가기 전 체크하세요!", subtitle: "외출 체크리스트 확인하기", icon: DSImage.umbrellaicon.uiImage()))
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.petid_Skyblue)
                    .frame(width: 40, height: 40)
                Image(systemName: "umbrella")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.petid_white)
            }
            .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("반려동물과 나가기 전 체크하세요!")
                    .font(.petIdBody2)
                    .foregroundColor(.gray)
                Text("외출 체크리스트 확인하기")
                    .font(.petIdBody1)
                    .bold()
            }
            .padding(.leading, 5)
            
            Spacer()
            
            ZStack{
                Capsule()
                    .fill(.white)
                    .frame(width: 50, height: 25)
                    .shadow(radius: 2)
                Text("NEW")
                    .font(.petIdBody3)
                    .bold()
                    .foregroundColor(.petid_new)
                    
            }
            .padding(.leading, 10)
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing, 10)
        }
        .frame(height: 60)
        .background(Color.petid_lightdark_skyblue)
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    Banner()
}
