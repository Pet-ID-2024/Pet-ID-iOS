//
//  UserInfoDetail.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/9/24.
//

import SwiftUI

struct UserInfoDetail: View {
    @ObservedObject var viewModel: UserInfoDetailViewModel
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
                
                Text("내 정보")
                
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
                    Text("홍길동")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("생년월일")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("1999.09.09")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("휴대폰 번호")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("010-1200-0034")
                        .foregroundColor(.petid_subtitle)
                }
                .font(.body2_reg)
                
                HStack{
                    Text("집 주소")
                        .foregroundColor(.petid_title)
                    Spacer()
                    Text("서울특별시 송파구 송파대로 12길 11\n송파아파트 101 동 1601호")
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.petid_subtitle)
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
    UserInfoDetail(viewModel: UserInfoDetailViewModel())
}
