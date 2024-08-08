//
//  AccessibilityRightView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/15/24.
//

import SwiftUI

struct AccessibilityRightView: View {
    @StateObject private var viewModel = AccessibilityRightViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("접근성 설정 안내")
                .font(.petIdTitle1)
                .padding(.bottom, 5)
            Text("PET ID 고객님의 편리한 앱 이용을 위해 \n접근권한 허용이 필요합니다.")
                .font(.petIdBody2)
                .foregroundColor(.petid_gray)
            
            Divider()
                
            
            ForEach(viewModel.items) { item in
                AccessibilityItemView(item: item)
            }
        }
        .padding()
        
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.petid_lightgray)
                    .frame(width: 360, height: 72)
                    .cornerRadius(10)
                VStack(alignment: .leading){
                    HStack {
                        DSImage.infoicon.toImage()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("접근권한 변경 방법")
                            .font(.petIdBody2)
                            .bold()
                        Spacer()
                    }
                    Text("설정>애플리케이션관리자>PETID")
                        .font(.petIdBody3)
                        .foregroundColor(.petid_subtitle)
                }
                .padding()
            }
            Text("선택적 접근권한은 동의하지 않아도 해당기능 외 앱 이용이 \n가능합니다.")
            .font(.petIdBody2)
            .foregroundColor(.petid_subtitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Button(action: {
                
            }) {
                Text("다음")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

        }
        .padding()
    }
}

#Preview {
    AccessibilityRightView()
}
