//
//  PetCaption.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/1/24.
//

import SwiftUI

struct PetCaption: View {
    @ObservedObject var viewModel: PetCaptionViewModel
    var coordinator: PetCaptionCoordinator?
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
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
            //            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("4/7")
                    .font(.body1_bold)
                    .foregroundColor(.petid_clearblue)
                Text("반려동물 \n사진 촬영을 시작할게요")
                    .font(.headline1)
                Text("AI가 반려동물의 정보를 가져올거에요!")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
            }
            .padding()
            
            Spacer()
            
            VStack {
                HStack {
                    Spacer()
                    
                    DSImage.captionicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                    Spacer()
                }
                
                
            }
//            .padding(.top, -50)
            
            Spacer()
            
            VStack {
                Text("가이드에 맞춰서 \n사진촬영을 해주세요!")
                    .font(.body2_reg)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, -30)
            
            //                        Spacer()
            
            Spacer()
            
            Button(action: {
                viewModel.navigateToCamera()
                print("카메라 눌림")
            }) {
                Text("촬영 시작")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.petid_clearblue)
                    .foregroundColor(.white)
                    .font(.body2_med)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    PetCaption(viewModel: PetCaptionViewModel())
}
