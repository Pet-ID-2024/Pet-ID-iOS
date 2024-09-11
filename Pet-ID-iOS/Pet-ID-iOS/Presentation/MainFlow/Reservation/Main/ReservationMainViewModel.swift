//
//  ReservationMainViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/26/24.
//

import SwiftUI
import Combine

enum ReservationMainViewModelResult {
    case selectHospital
}

@MainActor
final class ReservationMainViewModel: BaseViewModel<ReservationMainViewModelResult> {
    @Published var searchText: String = ""
    @Published var sidoLocations: [Location] = []
    @Published var selectedSidoLocation: Location = Location(id: 0, name: "서울")
    @Published var sigunguLocations: [Location] = []
    @Published var selectedsigunguLocation: Location = Location(id: 0, name: "송파구")
    
    @Published var isLoading: Bool = false
    
    private let addressFetcher: AddressFetcher = DefaultAddressFetcher()
    
    override init() {
        
        super.init()
        
        Task {
            await fetchLocationInfo()
        }
    }
    
    func toResult(result: ReservationMainViewModelResult) {
        self.result.send(result)
    }
}

extension ReservationMainViewModel {
    
    // 시도 선택 메서드
    func selectSido(location: Location)  {
        Task {
            self.selectedSidoLocation = location
            
            do {
                isLoading = true
                let sigungu = try await addressFetcher.sigungu(sidoId: selectedSidoLocation.id)
                sigunguLocations = sigungu
                isLoading = false
            } catch {
                isLoading = false
                logger.error(error)
            }
        }
    }
    
    func selectSigungu(location: Location) {
        self.selectedsigunguLocation = location
        /// 나중에 검색 부분 구현
    }
    
    // 정보 로딩
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
            self.selectedsigunguLocation = sigungu.first ?? Location(id: 1, name: "송파구")
            
            isLoading = false
        } catch {
            isLoading = true
            Logger().error(error)
        }
    }
}
