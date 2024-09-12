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
                    .foregroundColor(.petid_lightgray)
                    .padding()
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 10)
                
                VStack{
                    Spacer()
                    Text(viewModel.card.mainText)
                        .foregroundColor(.petid_gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    DSImage.petidicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 154)
                    Text(styledSubText(viewModel.card.subText))
                        .font(.petIdTitle3)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(action: {
                        
                    }) {
                        Text(viewModel.card.buttonText)
                            .font(.petIdBody1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_clearblue)
                            .foregroundColor(.petid_white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 10)
                    .padding()
                }
                .padding()
            }
        }
        .padding()
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
