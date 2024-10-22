//
//  ScanCheck.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/1/24.
//

import SwiftUI

struct ScanCheck: View {
    @ObservedObject var viewModel: ScanCheckViewModel
    var coordinator: ScanCoordinator?
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
            
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 10){
                    Text("5/7")
                        .font(.body1_bold)
                        .foregroundColor(.petid_clearblue)
                    
                    Text("반려동물 정보를 가져왔어요!")
                        .font(.headline1)
                    
                    Text("잘못된 정보는 수정할 수 있어요")
                        .font(.body3_med)
                        .foregroundColor(.petid_gray)
                }
                
                VStack(spacing: 30) {
                    InputField(title: "품종", text: $viewModel.productType)
                    InputField(title: "털 색깔", text: $viewModel.furColor)
                    InputField(title: "특징", text: $viewModel.furFeatures)
                    InputField(title: "몸무게", text: $viewModel.bodyWeight)
                }
                .padding(.top, 70)
                
                
                Spacer()
                
                Button {
                    viewModel.navigateToIC()
                    
                } label: {
                    Text("다음")
                        .foregroundColor(.white)
                        .font(.body2_med)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.petid_clearblue)
                        .cornerRadius(10)
                }
                //                .padding()
                
                
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ScanCheck(viewModel: ScanCheckViewModel(image: UIImage()))
}
