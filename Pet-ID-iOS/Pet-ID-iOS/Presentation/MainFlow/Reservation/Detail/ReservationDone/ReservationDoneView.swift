//
//  ReservationDoneView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/1/24.
//

import SwiftUI

struct ReservationDoneView: View {
    @ObservedObject var viewModel: ReservationDoneViewModel
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.navigateBack()
                }) {
                    DSImage.chevronicon.toImage()
                        .font(.title)
                        .foregroundColor(.petid_title)
                }
                Spacer()
            }
            .padding()
            
            VStack(spacing: 30){
                
                DSImage.petidiconok.toImage()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                Text("동물병원에서 예약을 \n확인하고 있어요!")
                    .font(.headline1)
                    .multilineTextAlignment(.center)
                Text("예약 확정은 알림으로 알려드려요")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
            }
            .padding(.top, 20)
            
            Spacer()
            
            
            Button {
                viewModel.complete()
            } label: {
                Text("확인")
                    .foregroundColor(.white)
                    .font(.body2_med)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.petid_clearblue)
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .padding()
    }
}

#Preview {
    ReservationDoneView(viewModel: ReservationDoneViewModel())
}
