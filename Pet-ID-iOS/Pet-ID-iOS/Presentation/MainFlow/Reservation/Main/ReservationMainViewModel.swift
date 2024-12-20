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
    @Published var selectedHospital: Hospital? = nil
    @Published var processedImageUrls: [Int: String] = [:] // 병원 ID별 첫 번째 Presigned URL
    
    @Published var isLoading: Bool = false
    @Published var isSortedByDistance: Bool = false
    
    @Published var userLatitude: Double = 0.0 // 사용자 위도
    @Published var userLongitude: Double = 0.0 // 사용자 경도
    
    private let addressFetcher: AddressFetcher = DefaultAddressFetcher()
     let hospitalFetcher: HospitalFetcher = DefaultHospitalFetcher()
    
    override init() {
        super.init()
        
        Task {
            await fetchLocationInfo() // 초기 위치 정보
            await fetchHospitals() // 초기 병원 정보
        }
    }
    
    func navigateToDetail(hospital: Hospital) {
        self.selectedHospital = hospital
        result.send(.selectHospital)
    }
    
    func setUserLocation(lat: Double, lon: Double) {
        userLatitude = lat
        userLongitude = lon
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
                self.selectedSigunguLocation = Location(id: 0, name: "선택") // 시군구 초기화
                self.eupmundongLocations = []
                self.selectedEupmundongLocation = Location(id: 0, name: "선택") // 읍면동 초기화
                hospitalList = [] // 병원 리스트 초기화
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
                self.selectedEupmundongLocation = Location(id: 0, name: "선택") // 읍면동 초기화
                hospitalList = [] // 병원 리스트 초기화
                isLoading = false
                
                // 병원 리스트 로드
                await fetchHospitals()
            } catch {
                isLoading = false
                print("읍면동 데이터 로드 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func selectEupmundong(location: Location) {
        self.selectedEupmundongLocation = location
        Task {
            await fetchHospitals()
        }
    }
    
    @MainActor func fetchLocationInfo() async {
        do {
            isLoading = true
            let sido = try await addressFetcher.sido()
            print("✅ Sido data: \(sido)")
            
            // 시도 데이터 설정
            self.sidoLocations = sido
            self.selectedSidoLocation = Location(id: 0, name: "선택")
            print("✅ Default Sido set to: \(self.selectedSidoLocation)")
            
            // 시군구와 읍면동 초기화
            self.sigunguLocations = []
            self.selectedSigunguLocation = Location(id: 0, name: "선택")
            self.eupmundongLocations = []
            self.selectedEupmundongLocation = Location(id: 0, name: "선택")
            
            // 병원 리스트 초기화
            self.hospitalList = []
            
            isLoading = false
        } catch {
            isLoading = false
            print("❌ 시도 데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    // 병원 정보 조회
    private func fetchHospitals() async {
        guard selectedSidoLocation.id != 0, selectedSigunguLocation.id != 0 else {
            print("❌ Sido or Sigungu not selected: \(selectedSidoLocation), \(selectedSigunguLocation)")
            return
        }
        
        do {
            isLoading = true
            hospitalList = try await hospitalFetcher.hospitals(
                sidoId: selectedSidoLocation.id,
                sigunguId: selectedSigunguLocation.id,
                eupmundongId: selectedEupmundongLocation.id != 0 ? selectedEupmundongLocation.id : nil
            )
            print("병원 리스트 업데이트됨: \(hospitalList)")
            isSortedByDistance = false
            
            // 병원의 첫 번째 이미지 Presigned URL 처리
            await fetchAllHospitalImages()
            
            isLoading = false
        } catch {
            isLoading = false
            print("병원 데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    func fetchHospitalsByDistance() async {
        guard selectedSidoLocation.id != 0, selectedSigunguLocation.id != 0 else { return }
        
        do {
            isLoading = true
            hospitalList = try await hospitalFetcher.getHospitals(
                sido: selectedSidoLocation.id,
                sigungu: selectedSigunguLocation.id,
                eupmundong: selectedEupmundongLocation.id,
                lat: userLatitude,
                lon: userLongitude
            )
            isSortedByDistance = true
            
            // 병원의 첫 번째 이미지 Presigned URL 처리
            await fetchAllHospitalImages()
            
            isLoading = false
        } catch {
            isSortedByDistance = false
            isLoading = false
            print("거리순 병원 데이터 로드 실패: \(error.localizedDescription)")
        }
    }
    
    private func fetchPresignedUrl(for hospital: Hospital) async {
        // 배열이 비어있는 경우 처리
        guard let firstImagePath = hospital.imageUrl?.first, !firstImagePath.isEmpty else {
            print("❌ 병원 ID \(hospital.id): 이미지 배열이 비어있거나 유효하지 않음")
            return
        }

        do {
            // Presigned URL 생성
            if let presignedUrl = try await hospitalFetcher.hospitalImage(filePath: firstImagePath) {
                DispatchQueue.main.async {
                    self.processedImageUrls[hospital.id] = presignedUrl.absoluteString
                    print("✅ 병원 ID \(hospital.id): Presigned URL \(presignedUrl.absoluteString)")
                }
            } else {
                print("❌ 병원 ID \(hospital.id): Presigned URL 생성 실패")
            }
        } catch {
            print("❌ 병원 ID \(hospital.id): Presigned URL 요청 실패 \(error.localizedDescription)")
        }
    }
    
    
    private func fetchAllHospitalImages() async {
        for hospital in hospitalList {
            await fetchPresignedUrl(for: hospital)
        }
    }
}
