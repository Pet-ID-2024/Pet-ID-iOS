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
    @State var locationEupmundongExpended: Bool = false
    
    @ObservedObject var viewModel: ReservationMainViewModel
    
    init(viewModel: ReservationMainViewModel) {
        self.viewModel = viewModel
    }
    
    var filteredHospitalList: [Hospital] {
        if viewModel.searchText.isEmpty {
            return viewModel.hospitalList
        } else {
            return viewModel.hospitalList.filter { $0.name.contains(viewModel.searchText) }
        }
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
        .onAppear { // 여기서 초기화 작업 수행
            Task {
                await viewModel.fetchLocationInfo()
            }
        }
    }
    
    var naviBar: some View {
        HStack {
            Text("병원 예약")
                .font(.body2_reg)
        }
        .padding(.vertical, 24)
    }
    
    var searchBar: some View {
        
        ZStack {
            
            TextField("", text: $viewModel.searchText)
            
            HStack {
                Text("검색")
                    .foregroundStyle(Color.petid_b4)
                    .opacity(viewModel.searchText.isEmpty ? 1 : 0)
                
                Spacer()
                
                Button {
                    
                } label: {
                    DSImage.searchicon.toImage()
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.leading, -35)
                }
                
            }
            
        }
        .padding(.vertical, 11)
        .padding(.leading, 22)
        .background(Color.petid_f5)
        .cornerRadius(21.5)
    }
    
    var placeDropDownFilterView: some View {
        
        HStack {
            // 시도 드롭다운
            HStack(spacing: 8) {
                Text(viewModel.selectedSidoLocation.name)
                    .font(.body4_med)
                
                Image(.down)
                    .rotationEffect(.degrees(locationSidoExpended ? -180 : 0))
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 14)
            .overlay(
                RoundedRectangle(cornerRadius: 1234)
                    .stroke(Color.petid_e9, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    locationSidoExpended.toggle()
                    locationSigunguExpended = false
                    locationEupmundongExpended = false
                }
            }
            .overlay(
                VStack(alignment: .leading) {
                    ForEach(viewModel.sidoLocations, id: \.id) { location in
                        Button(
                            action: {
                                withAnimation {
                                    viewModel.selectSido(location: location)
                                    locationSidoExpended.toggle()
                                    
                                }
                            },
                            label: {
                                Text(location.name)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .font(.body4_med)
                                    .foregroundStyle(Color.petid_title)
                            }
                        )
                    }
                }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .offset(y: locationSidoExpended ? 5 : 0)
                    .opacity(locationSidoExpended ? 1 : 0)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .alignmentGuide(.bottom, computeValue: { $0[.top] })
                    .alignmentGuide(.leading, computeValue: { $0[.leading] })
                    .frame(minWidth: 90),
                alignment: .bottomLeading
            )
            
            // 시군구
            HStack(spacing: 8) {
                Text(viewModel.selectedSigunguLocation.name)
                    .font(.body4_med)
                
                Image(.down)
                    .rotationEffect(.degrees(locationSigunguExpended ? -180 : 0))
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 14)
            .overlay(
                RoundedRectangle(cornerRadius: 1234)
                    .stroke(Color.petid_lightgray, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    locationSigunguExpended.toggle()
                    locationSidoExpended = false
                    locationEupmundongExpended = false
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
                                    .font(.body4_med)
                                    .foregroundStyle(Color.petid_title)
                            }
                        )
                    }
                }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .offset(y: locationSigunguExpended ? 5 : 0)
                    .opacity(locationSigunguExpended ? 1 : 0)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .alignmentGuide(.bottom, computeValue: { $0[.top] })
                    .alignmentGuide(.leading, computeValue: { $0[.leading] })
                    .frame(minWidth: 90),
                alignment: .bottomLeading
            )
            
            // 읍면동
            HStack(spacing: 8) {
                Text(viewModel.selectedEupmundongLocation.name)
                    .font(.body4_med)
                
                Image(.down)
                    .rotationEffect(.degrees(locationEupmundongExpended ? -180 : 0))
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 14)
            .overlay(
                RoundedRectangle(cornerRadius: 1234)
                    .stroke(Color.petid_lightgray, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    locationEupmundongExpended.toggle()
                    locationSidoExpended = false
                    locationSigunguExpended = false
                }
            }
            .overlay(
                VStack(alignment: .leading) {
                    ForEach(viewModel.eupmundongLocations, id: \.id) { location in
                        Button(
                            action: {
                                withAnimation {
                                    viewModel.selectEupmundong(location: location) // 선택한 읍면동으로 변경
                                    locationEupmundongExpended.toggle() // 선택 후 드롭다운 닫기
                                }
                            },
                            label: {
                                Text(location.name)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .font(.body4_med)
                                    .foregroundStyle(Color.petid_title)
                            }
                        )
                    }
                }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .offset(y: locationEupmundongExpended ? 5 : 0)
                    .opacity(locationEupmundongExpended ? 1 : 0)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .alignmentGuide(.bottom, computeValue: { $0[.top] })
                    .alignmentGuide(.leading, computeValue: { $0[.leading] })
                    .frame(minWidth: 90),
                alignment: .bottomLeading
            )
            
            Spacer()
            
            HStack(spacing: -3) {
                Button {
                    Task {
                        /*viewModel.setUserLocation(lat: 37.5665, lon: 126.9780)*/ // 서울 중심 좌표
                        await viewModel.fetchHospitalsByDistance()
                    }
                } label: {
                    Text("가까운 순")
                        .foregroundStyle(Color.petid_subtitle)
                        .font(.body4_med)
                    
                    DSImage.filtericon.toImage()
                        .resizable()
                        .frame(width: 23, height: 22)
                }
            }
            .contentShape(Rectangle())
            //            .onTapGesture {
            //                // Action for "가까운 순" filter
            //            }
        }
        .zIndex(10)
    }
    
    var listView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(filteredHospitalList, id: \.self) { hospital in
                    VStack(spacing: 0) {
                        Button(action: {
                            viewModel.navigateToDetail(hospital: hospital)
                        }) {
                            HStack(alignment: .center, spacing: 22) {
                                if let imageUrl = viewModel.processedImageUrls[hospital.id],
                                   let url = URL(string: imageUrl) {
                                    KFImage(url)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90) // 크기를 병원 카드의 높이와 맞춤
                                        .clipped()
                                } else {
                                    DSImage.noimageicon.toImage()
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(hospital.name)
                                        .font(.body2_bold)
                                        .foregroundStyle(Color.petid_title)
                                    
                                    Text("\(hospital.vet) 원장")
                                        .font(.body3_med)
                                        .foregroundStyle(Color.petid_title)
                                    
                                    Spacer()
                                        .frame(height: 11)
                                    
                                    Text(hospital.address)
                                    //                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                        .font(.caption1_reg)
                                        .foregroundStyle(Color.petid_subtitle)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 21)
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color.petid_lightgray)
                    }
                    .contentShape(Rectangle())
                }
            }
        }
    }
}

#Preview {
    ReservationMainView(viewModel: ReservationMainViewModel())
}
