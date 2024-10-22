//
//  PetCardView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI

struct PetCardView: View {
    @StateObject private var viewModel = PetCardViewModel()
    var coordinator: HomeCoordinator?
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(.petid_f4)
                    .padding()
                    .shadow(color: .black.opacity(0.25), radius: 3, y: 3)
                
                VStack{
                    Text(viewModel.card.mainText)
                        .multilineTextAlignment(.center)
                        .font(.body3_reg)
                        .foregroundColor(.petid_gu2)
                        .padding()
                        .padding(.top, 20)
                    DSImage.petidicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 154)
                    Text(styledSubText(viewModel.card.subText))
                        .font(.headline15)
                        .lineSpacing(8)
//                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(action: {
                        coordinator?.goToPetStart()
                    }) {
                        Text(viewModel.card.buttonText)
                            .font(.body3_med)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_clearblue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 10)
//                    .padding(.bottom, 10)
                    .padding()
                }
                .padding()
            }
        }
    }
    
    private func styledSubText(_ text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        if let range = attributedString.range(of: "펫 아이디") {
            attributedString[range].foregroundColor = .blue
        }
        return attributedString
    }
}

#Preview {
    PetCardView(coordinator: nil)
}
