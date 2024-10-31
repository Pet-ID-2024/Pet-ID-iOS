//
//  Dialog1.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/23/24.
//

import SwiftUI

struct Dialog1: View {
    @State var isPresented: Bool
    var body: some View {
            if isPresented {
                    VStack(spacing: 12) {
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    isPresented = false
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                                    .padding(8)
                            }
                        }

                        Text("코코는 반려동물 등록 대상이에요!")
                            .font(.body1_med)
                            .foregroundColor(.black)

                        Text("간단하게 등록할 수 있는\n내 주변 동물병원을 알려드려요!")
                            .font(.body2_reg)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.petid_subtitle)

                        Button(action: {
                            print("병원 알아보기 버튼 클릭")
                        }) {
                            Text("병원 알아보기")
                                .font(.body2_reg)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.petid_clearblue)
                                .cornerRadius(8)
                        }
                        .padding(.top, 8)
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
    Dialog1(isPresented: true)
}

