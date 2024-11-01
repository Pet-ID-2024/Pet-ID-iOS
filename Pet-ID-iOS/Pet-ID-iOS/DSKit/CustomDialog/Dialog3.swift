//
//  Dialog3.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/23/24.
//

import SwiftUI

struct Dialog3: View {
    @State var isPresented: Bool
    var Title: String
    var body: some View {
        if isPresented {
            VStack(spacing: 12) {
                Text(Title)
                    .font(.body1_med)
                    .foregroundColor(.black)
                
                HStack{
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("아니오")
                            .font(.body2_med)
                            .foregroundColor(.petid_subtitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_d9)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)
                    Button(action: {
                        print("병원 알아보기 버튼 클릭")
                    }) {
                        Text("예")
                            .font(.body2_med)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_clearblue)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)
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
    Dialog3(isPresented: true, Title: "예약을 취소 하시겠습니까?")
}
