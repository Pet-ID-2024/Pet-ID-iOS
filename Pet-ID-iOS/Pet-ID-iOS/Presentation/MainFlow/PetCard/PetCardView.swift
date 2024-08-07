//
//  PetCardView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI

struct PetCardView: View {
    @StateObject private var viewModel = PetCardViewModel()
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .cornerRadius(10)
                    .foregroundColor(.petid_lightgrey)
                    .padding()
                    .shadow(radius: 5)
                
                VStack{
                    Text(viewModel.card.mainText)
                        .multilineTextAlignment(.center)
                        .padding()
                    DSImage.petidicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                    Text(styledSubText(viewModel.card.subText))
                        .font(.petIdTitle3)
                        .bold()
                        .multilineTextAlignment(.center)
                    Button(action: {
                        
                    }) {
                        Text(viewModel.card.buttonText)
                            .font(.petIdBody1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 10)
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
    PetCardView()
}
