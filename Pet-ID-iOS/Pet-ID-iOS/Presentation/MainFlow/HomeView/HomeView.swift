//
//  HomeView.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
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
                    
                    Button {
                        
                    } label: {
                        Banner()
                    }
                    
                    
                    PetCardView()
                    
                    
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
