//
//  RegistrationSuccess.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/11/24.
//

import SwiftUI

//struct RegistrationSuccess: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    var body: some View {
//        NavigationView{
//            VStack {
//                HStack {
//                    Button(action: {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.black)
//                    }
//                    Spacer()
//                }
//                
//                VStack(spacing:10){
//                    Text("축하합니다.")
//                        .foregroundColor(.blue)
//                        .font(.system(size: 24, weight: .bold))
//                    Text("펫아이디 카드를 확인해보세요")
//                        .font(.system(size: 24))
//                    Text("세상에 하나뿐인 펫 아이디에요!")
//                        .font(.system(size: 12))
//                        .foregroundColor(.gray)
//                }
//                .padding()
//                
//                Image(systemName: "pencil")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                
//                Spacer()
//                
//                NavigationLink(destination: MainView().navigationBarBackButtonHidden()) {
//                    Text("다음")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//#Preview {
//    RegistrationSuccess()
//}
