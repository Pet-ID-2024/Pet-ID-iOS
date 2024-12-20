//
//  Dialog3.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/23/24.
//

import SwiftUI

// 예약취소
struct Dialog3: View {
    @ObservedObject var viewModel: Dialog3ViewModel
    //    var title: String
    var body: some View {
        if viewModel.isPresented {
            VStack(spacing: 12) {
                Text(viewModel.title)
                    .font(.body1_med)
                    .foregroundColor(.black)
                
                HStack{
                    Button {
                        viewModel.closeDialog()
                    } label: {
                        Text("아니오")
                            .font(.body2_med)
                            .foregroundColor(.petid_subtitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_d9)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)
                    
                    Button {
                        viewModel.cancelReservation()
                    } label: {
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
    Dialog3(viewModel: Dialog3ViewModel(title: "예약 취소?", orderId: 1))
}
