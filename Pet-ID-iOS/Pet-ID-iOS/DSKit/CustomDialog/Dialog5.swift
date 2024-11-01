//
//  Dialog5.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/23/24.
//

import SwiftUI

struct Dialog5: View {
    @State var isPresented: Bool
    var image: Image
    var buttonString: String
    var body: some View {
        if isPresented {
            VStack(spacing: 12) {
                Text("반려 동물 등록은 왜 해야할까?")
                    .font(.body2_bold)
                    .foregroundColor(.petid_blue)
                    .multilineTextAlignment(.center)
                VStack(spacing: 5){
                    Text("혹시 알고 계셨나요?")
                        .foregroundColor(.black)
                        .font(.body1_bold)
                    Text("한국에는 매년 11만 마리 이상의 \n반려동물이 길을 잃거나 버려지고 있어요.")
                        .font(.body2_med)
                        .multilineTextAlignment(.center)
                }
                
                image
                    .resizable()
                    .frame(width: 162, height: 162)
                
                Button(action: {
                    
                }) {
                    Text(buttonString)
                        .font(.body2_med)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.petid_clearblue)
                        .cornerRadius(8)
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .padding(.horizontal, 40) // 양 옆 여백 조정
            .shadow(radius: 10) // 그림자 추가
        }
    }
}

#Preview {
    Dialog5(isPresented: true, image: DSImage.dialogicon1.toImage(), buttonString: "다음")
}
