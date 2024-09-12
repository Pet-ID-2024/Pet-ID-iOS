//
//  Banner.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI

struct TopBanner: View {
    @StateObject private var viewModel = TopBannerViewModel(banner: TopBannerModel(title: "반려동물과 나가기 전 체크하세요!", subtitle: "외출 체크리스트 확인하기", icon: DSImage.arrowicon.toImage()))
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("반려동물과 나가기 전 체크하세요!")
                    .font(.petIdBody2)
                    .foregroundColor(.gray)
                Text("외출 체크리스트 확인하기")
                    .font(.petIdBody1)
                    .foregroundColor(.petid_title)
                    .bold()
            }
            .padding(.leading, 20)
            
            Spacer()
            
            ZStack {
                viewModel.banner.icon
                    .resizable()
                    .frame(width: 10, height: 20)
//                    .foregroundColor(.petid_white)
            }
            .padding()
        }
        .frame(height: 60)
        .background(DSImage.bannerbg.toImage()
            .resizable())
        .cornerRadius(10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    TopBanner()
}
