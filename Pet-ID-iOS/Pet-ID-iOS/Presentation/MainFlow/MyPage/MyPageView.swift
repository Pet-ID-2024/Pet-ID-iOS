//
//  MyPageView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/5/24.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Header
        
        Rectangle()
            .frame(height: 8)
            .foregroundColor(.petid_f5)
        
        TopList
        
        Rectangle()
            .frame(height: 8)
            .foregroundColor(.petid_f5)
        
        BottomList
        
        Text("앱 버전 1.05")
            .foregroundColor(.petid_subtitle)
    }
    
    
    
    var Header: some View {
        VStack {
            
            Text("my")
            
            //            Spacer()
            Button {
                viewModel.navigateToUser()
            } label: {
                HStack(spacing: 20) {
                        DSImage.randomicon.toImage()
                            .resizable()
                            .frame(width: 68, height: 68)
                            .multilineTextAlignment(.leading)
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("랜덤이름")
                            .font(.body1_med)
                            .foregroundColor(.petid_title)
                        Text("내 정보 수정하기")
                            .font(.body2_reg)
                            .foregroundColor(.petid_subtitle)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
        }
        .padding()
    }
    
    var TopList: some View {
        VStack{
            Button {
                viewModel.navigateToPet()
            } label: {
                HStack {
                    Text("반려동물 정보")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            //        .padding()
            
            Button {
                viewModel.navigateToReservationList()
            } label: {
                HStack {
                    Text("예약 내역")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .padding()
        .padding(.top, -10)
    }
    
    var BottomList: some View {
        VStack{
            Button {
                print("클릭")
            } label: {
                HStack {
                    Text("약관 및 개인정보 처리 동의")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            //        .padding()
            
            Button {
                print("클릭")
            } label: {
                HStack {
                    Text("개인정보 처리방침")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Button {
                print("클릭")
            } label: {
                HStack {
                    Text("공지사항")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Button {
                print("클릭")
            } label: {
                HStack {
                    Text("자주하는 질문")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Button {
                print("클릭")
            } label: {
                HStack {
                    Text("탈퇴하기")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .padding()
        .padding(.top, -10)
    }
    
}
#Preview {
    MyPageView(viewModel: MyPageViewModel())
}
