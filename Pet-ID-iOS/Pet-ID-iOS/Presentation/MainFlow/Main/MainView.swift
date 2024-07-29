//
//  MainView.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Text("Pet ID")
                        .font(.petIdTitle2)
                        .foregroundColor(.petid_blue)
                    Spacer()
                    Image(.notificationicon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                .padding()
                
                Banner()
                
                PetCard()
                
            }
        }
    }
}

#Preview {
    MainView()
}
