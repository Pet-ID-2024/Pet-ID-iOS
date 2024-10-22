//
//  Done.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/1/24.
//

import SwiftUI

struct PetCardDone: View {
    @ObservedObject var viewModel: PetCardDoneViewModel
    var coordinator: PetCardDoneCoordinator?
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
                
                Text("펫 아이디 카드를 \n확인해 보세요!")
                    .font(.headline1)
                    .multilineTextAlignment(.center)
                Text("회원님이 알려준 정보로 카드를 만들었어요!")
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
    PetCardDone(viewModel: PetCardDoneViewModel())
}
