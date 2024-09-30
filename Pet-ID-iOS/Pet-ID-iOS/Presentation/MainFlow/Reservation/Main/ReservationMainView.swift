//
//  ReservationMainView.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/13/24.
//

import SwiftUI
import Kingfisher

struct ReservationMainView: View {
    
    @State var searchKeyard: String = ""
    @State var searchBarHeight: CGFloat = 0
    
    @State var locationSidoExpended: Bool = false
    @State var locationSigunguExpended: Bool = false
    
    @ObservedObject var viewModel: ReservationMainViewModel
    
    init(viewModel: ReservationMainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            naviBar
            
            searchBar
            
            Spacer()
                .frame(height: 24)
            
            placeDropDownFilterView
            
            Spacer()
                .frame(height: 10)
            
            listView
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
    
    var naviBar: some View {
        HStack {
            Text("병원 예약")
                .font(.petIdBody1)
        }
        .padding(.vertical, 24)
    }
    
    var searchBar: some View {
        
        ZStack {
            
            TextField("", text: $viewModel.searchText)
            
            HStack {
                Text("검색")
                    .foregroundStyle(Color.petid_subtitle)
                    .opacity(viewModel.searchText.isEmpty ? 1 : 0)
                
                Spacer()
            }
            
        }
        .padding(.vertical, 11)
        .padding(.leading, 22)
        .background(Color.petid_lightgrey)
        .cornerRadius(21.5)
    }
    
    var placeDropDownFilterView: some View {
        
        HStack {
            
                HStack(spacing: 8) {
                    Text(viewModel.selectedSidoLocation.name)
                        .font(.petIdBody3)
                    
                    Image(.down)
                        .rotationEffect(.degrees(locationSidoExpended ? -180 : 0))
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 14)
                .overlay(
                    RoundedRectangle(cornerRadius: 1234)
                        .stroke(Color.petid_lightgrey, lineWidth: 1)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        locationSidoExpended.toggle()
                        locationSigunguExpended = false
                    }
                }
                .overlay(
                    VStack(alignment: .leading) {
                        ForEach(viewModel.sidoLocations, id: \.id) { location in
                            
                            Button(
                                action: {
                                    withAnimation {
                                        locationSidoExpended.toggle()
                                        viewModel.selectSido(location: location)
                                    }
                                },
                                label: {
                                    
                                    Text(location.name)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .font(.petIdBody3)
                                        .foregroundStyle(Color.petid_title)
                                    
                                }
                            )
                        }
                    }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.petid_grey, lineWidth: 1)
                                .background(Color.white)
                                .cornerRadius(8)
                        )
                        .offset(y: 4)
                        .opacity(locationSidoExpended ? 1 : 0)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .alignmentGuide(.bottom, computeValue: {
                            $0[.top]
                        })
                        .alignmentGuide(.leading, computeValue: {
                            $0[.leading]
                        })
                        .frame(minWidth: 90)
                    ,
                    alignment: Alignment(horizontal: .leading, vertical: .bottom)
                )
                
                HStack(spacing: 8) {
                    Text(viewModel.selectedsigunguLocation.name)
                        .font(.petIdBody3)
                    
                    Image(.down)
                        .rotationEffect(.degrees(locationSigunguExpended ? -180 : 0))
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 14)
                .overlay(
                    RoundedRectangle(cornerRadius: 1234)
                        .stroke(Color.petid_lightgrey, lineWidth: 1)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        locationSigunguExpended.toggle()
                        locationSidoExpended = false
                    }
                }
                .overlay(
                    VStack(alignment: .leading) {
                        ForEach(viewModel.sigunguLocations, id: \.id) { location in
                            
                            Button(
                                action: {
                                    withAnimation {
                                        viewModel.selectSigungu(location: location)
                                        locationSigunguExpended.toggle()
                                    }
                                },
                                label: {
                                    
                                    Text(location.name)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 4)
                                        .font(.petIdBody3)
                                        .foregroundStyle(Color.petid_title)
                                    
                                }
                            )
                        }
                    }
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.petid_grey, lineWidth: 1)
                                .background(Color.white)
                                .cornerRadius(8)
                        )
                        .offset(y: 4)
                        .opacity(locationSigunguExpended ? 1 : 0)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                        .alignmentGuide(.bottom, computeValue: {
                            $0[.top]
                        })
                        .alignmentGuide(.leading, computeValue: {
                            $0[.leading]
                        })
                        .frame(minWidth: 90)
                    ,
                    alignment: Alignment(horizontal: .leading, vertical: .bottom)
                )
                
            
            Spacer()
            
            HStack {
                Text("가까운순")
                    .foregroundStyle(Color.petid_subtitle)
                    .font(.petIdBody3)
                
                // 이미지로 변경 예정
                Text("필터")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                
            }
        }
        .zIndex(10)
        
    }
    
    var listView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(1...10, id: \.self) { count in
                    VStack(spacing: 0) {
                        HStack(alignment: .center, spacing: 22) {

                            KFImage(string: "https://postfiles.pstatic.net/MjAyMTA2MDlfMjM0/MDAxNjIzMjIyMjU5Mjgz.cv3La0LhNLcFnPJ091a8jHz6K8-UoA8BIQrZRZcJ54sg.z4v7OPd07iQ7gD7gj1I_WUxRjVxilKiwwvjV1uvHzhcg.PNG.sglucia_/%EB%9E%84%EB%A1%9C%EC%8D%AC%EA%B8%8002.png?type=w773")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text("꿈이 크는 동물병원")
                                    .font(.petIdBody1)
                                    .foregroundStyle(Color.petid_title)
                                
                                Text("원장님 이름")
                                    .font(.petIdBody2)
                                    .foregroundStyle(Color.petid_title)
                                
                                Spacer()
                                    .frame(height: 11)
                                
                                Text("주소")
                                    .font(.petIdCaption1)
                                    .foregroundStyle(Color.petid_subtitle)
                                
                            }
                            Spacer()
                        }
                        .padding(.vertical, 21)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.petid_lightgrey)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                    }
                }
            }
        }
    }
    
}

#Preview {
    ReservationMainView(viewModel: ReservationMainViewModel())
}
