//
//  HomeView.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var coordinator: HomeCoordinator
    
    var body: some View {
        VStack {
            HStack{
                Text("Pet ID")
                    .font(.petIdTitle2)
                    .foregroundColor(.petid_blue)
                Spacer()
                
                Button {
                    
                } label: {
                    DSImage.notificationicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
            }
            .padding()
            
            ScrollView {
                VStack{
                    
                    Button {
                        
                    } label: {
                        TopBanner()
                    }
                    
//                    Button {
//                        coordinator.goToPetStart()
//                    } label: {
//                        PetCardView()
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    
                    PetCardView(coordinator: coordinator)
                    
                    VStack(alignment: .leading, spacing: -30) {
                        Text("반려인 라이프 스타일 추천")
                            .bold()
                            .padding()
                        VStack(spacing: -50){
                            BannerView()
                                .frame(height: 180)
                            //                        .background(Color.blue)
                            //                        .cornerRadius(25)
                            
                            BannerView()
                                .frame(height: 180)
                        }
                        
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(), coordinator: HomeCoordinator(UINavigationController()))
}
