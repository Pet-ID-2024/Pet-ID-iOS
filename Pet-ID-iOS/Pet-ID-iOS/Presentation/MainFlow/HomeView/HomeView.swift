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
                DSImage.petidmain.toImage()
                    .resizable()
                    .frame(width: 31, height: 35)
                Text("펫아이디를 만들어보세요.")
                    .font(.body3_bold)
                    .foregroundColor(.petid_under_bar)
                
                Spacer()
                
                Button {
                    
                } label: {
                    
                    DSImage.notificationicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
            }
            .padding(.horizontal)
//                        .padding(.bottom, 8)
            
            ScrollView {
                VStack{
                    PetCardView(coordinator: coordinator)
                    
                    HStack {
                        Text("🐶 반려 정보 tip")
                            .font(.body1_semi)
                            .foregroundColor(.petid_title)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("더보기")
                                .font(.caption1_reg)
                                .foregroundColor(.petid_b4)
                        }
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    
                    BannerView()
                    
                    //                        BannerView()
                    
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .padding([.leading, .trailing], 20)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(), coordinator: HomeCoordinator(UINavigationController()))
}
