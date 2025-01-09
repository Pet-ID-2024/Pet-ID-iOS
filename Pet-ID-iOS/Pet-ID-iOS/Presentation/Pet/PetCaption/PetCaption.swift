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
                .padding()
                
                Spacer()
            }
            
            
            VStack(alignment: .leading, spacing: 20) {
                Text("4/7")
                    .font(.body1_bold)
                    .foregroundColor(.petid_clearblue)
                VStack(alignment: .leading, spacing: 20){
                    Text("반려동물 \n사진 촬영을 시작할게요")
                        .font(.headline1)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("• 사진을 촬영하면 ")
                            .foregroundColor(.petid_gray)
                        + Text("AI가 자동으로")
                            .foregroundColor(.petid_clearblue)
                        + Text(" 반려동물의\n   주요 특징을 인식합니다.")
                            .foregroundColor(.petid_gray)
                        
                        Text("• 촬영된 사진은 ")
                            .foregroundColor(.petid_gray)
                        + Text("펫 카드")
                            .foregroundColor(.petid_clearblue)
                        + Text(" 제작에 사용됩니다. \n   재촬영을 원하실 경우, 다시 촬영 가능합니다.")
                            .foregroundColor(.petid_gray)
                    }
                    .font(.body3_reg)
                }
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, -20)
            .padding()
            
            Spacer()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    GeometryReader { geometry in
                        DSImage.captionicon.toImage()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                width: geometry.size.width * 0.7,
                                height: geometry.size.width * 0.7
                            )
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    .frame(width: 250, height: 30)
                    Spacer()
                }
                
                Spacer()
            }
            //            .padding(.top, -50)
            
            Spacer()
            
            VStack {
                Text("가이드에 맞춰서 촬영해 주세요!")
                    .font(.body3_reg)
                    .foregroundColor(.petid_under_bar)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, -30)
            
            //                        Spacer()
            
            Spacer()
            
            Button(action: {
                viewModel.navigateToCamera()
//                viewModel.navigateToScan()
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
    PetCaption(viewModel: PetCaptionViewModel(temporaryData: [:]))
}
