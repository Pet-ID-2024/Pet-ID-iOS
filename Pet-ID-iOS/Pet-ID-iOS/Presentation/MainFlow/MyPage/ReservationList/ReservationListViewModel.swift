import Foundation

enum ReservationListState {
    case back
    //    case showCancellationSuccess
}

class ReservationListViewModel: BaseViewModel<ReservationListState> {
    
    @Published var reservations: [ReservationList] = []
    private let fetcher: ReservationListFetcher
    
    init(fetcher: ReservationListFetcher = DefaultReservationListFetcher()) {
        self.fetcher = fetcher
        super.init()
        fetchReservations(status: .all)
    }
    
    func navigateBack() {
        result.send(.back)
    }
    
    func fetchReservations(status: ReservationStatus) {
        Task {
            do {
                let fetchedReservations = try await fetcher.fetchReservations(status: status)
                DispatchQueue.main.async {
                    self.reservations = fetchedReservations.sorted(by: { $0.date > $1.date})
                }
            } catch {
                Logger().error("❌ 예약 목록 조회 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func removeReservation(_ reservation: ReservationList) {
        DispatchQueue.main.async {
            self.reservations.removeAll { $0.id == reservation.id }
        }
    }
}
