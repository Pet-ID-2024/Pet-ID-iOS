import Foundation
import Combine


enum ReservationDetailState: String {
    case reservation
    case back
}

class ReservationDetailViewModel: BaseViewModel<ReservationDetailState> {
    @Published var hospitalName: String = "도그마루 동물병원"
    @Published var directorName: String = "홍길동 원장"
    @Published var operatingHours: String = "10:00 - 20:00 (13:00 - 14:00 휴게시간)"
    @Published var address: String = "서울 송파구 송파대로11길 1-1 A동 1층"
    @Published var contactNumber: String = "02-123-1234"
    
    
    func reservation() {
        result.send(.reservation)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
