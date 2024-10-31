//
//  Dialog4.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/23/24.
//

import SwiftUI

struct Dialog4: View {
    @State var isPresented: Bool
    var body: some View {
        if isPresented {
            VStack(spacing: 12) {
                Text("동물병원 방문시 \n외장칩 번호를 알려주세요.")
                    .font(.body1_med)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Button(action: {
                    isPresented = false
                }) {
                    Text("확인했습니다")
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
    Dialog4(isPresented: true)
}
