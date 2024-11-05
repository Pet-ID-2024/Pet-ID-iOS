//
//  ReservationMainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import SwiftUI
import Combine

enum ReservationMainState {
    case selectHospital
    case search
}

@MainActor
final class ReservationMainViewModel: BaseViewModel<ReservationMainState> {
    @Published var searchText: String = ""
    @Published var sidoLocations: [Location] = []
    @Published var selectedSidoLocation: Location = Location(id: 0, name: "선택")
    @Published var sigunguLocations: [Location] = []
    @Published var selectedSigunguLocation: Location = Location(id: 0, name: "선택")
    @Published var eupmundongLocations: [Location] = []
    @Published var selectedEupmundongLocation: Location = Location(id: 0, name: "선택")
    @Published var hospitalList: [Hospital] = []
    
    @Published var isLoading: Bool = false
    
    private let addressFetcher: AddressFetcher = DefaultAddressFetcher()
    private let hospitalFetcher: HospitalFetcher = DefaultHospitalFetcher()
    
    override init() {
        super.init()
        
        Task {
            await fetchLocationInfo() // 초기 위치 정보
            await fetchHospitals() // 초기 병원 정보
        }
    }
    
    func navigateToDetail() {
        result.send(.selectHospital)
    }
}

extension ReservationMainViewModel {
    
    func selectSido(location: Location) {
        Task {
            self.selectedSidoLocation = location
            do {
                isLoading = true
                let sigungu = try await addressFetcher.sigungu(sidoId: selectedSidoLocation.id)
                sigunguLocations = sigungu
                isLoading = false
            } catch {
                isLoading = false
                print("시군구 데이터 로드 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func selectSigungu(location: Location) {
        self.selectedSigunguLocation = location
        Task {
            do {
                isLoading = true
                let eupmundong = try await addressFetcher.eupmundong(sigunguId: selectedSigunguLocation.id)
                eupmundongLocations = eupmundong
                isLoading = false
            } catch {
                isLoading = false
                print("읍면동 데이터 로드 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func selectEupmundong(location: Location) {
        self.selectedEupmundongLocation = location
    }
    
    @MainActor func fetchLocationInfo() async {
        do {
            isLoading = true
            let sido = try await addressFetcher.sido()
            let sigungu: [Location]
            
            if let firstSido = sido.first {
                sigungu = try await addressFetcher.sigungu(sidoId: firstSido.id)
                self.selectedSidoLocation = firstSido
            } else {
                self.selectedSidoLocation = Location(id: 1, name: "서울")
                sigungu = try await addressFetcher.sigungu(sidoId: 1)
            }
            
            self.sidoLocations = sido
            self.sigunguLocations = sigungu
            self.selectedSigunguLocation = sigungu.first ?? Location(id: 1, name: "송파구")
            isLoading = false
        } catch {
            isLoading = false
            print("시도 데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // 병원 정보 조회
    private func fetchHospitals() async {
            guard selectedSidoLocation.id != 0, selectedSigunguLocation.id != 0 else { return }

            do {
                isLoading = true
                hospitalList = try await hospitalFetcher.hospitals(
                    sidoId: selectedSidoLocation.id,
                    sigunguId: selectedSigunguLocation.id,
                    eupmundongId: selectedEupmundongLocation.id != 0 ? selectedEupmundongLocation.id : nil
                )
                print("병원 리스트 업데이트됨: \(hospitalList)")
                isLoading = false
            } catch {
                isLoading = false
                print("병원 데이터 로드 실패: \(error.localizedDescription)")
            }
        }
    }
