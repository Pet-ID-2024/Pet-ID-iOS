import Foundation
import Combine


enum ReservationChoiceState: String {
    case done
    case back
}

class ReservationChoiceViewModel: BaseViewModel<ReservationChoiceState> {
    @Published var selectedDate = Date()
        @Published var selectedTime: String? = nil

        let availableTimesMorning = ["10:00", "10:30", "11:00", "11:30"]
        let availableTimesAfternoon = ["12:00", "12:30", "2:30", "3:00", "4:00", "4:30", "5:00", "5:30", "6:30", "7:00", "7:30"]

//        private let coordinator: ReservationChoiceCoordinator
//
//        init(coordinator: ReservationChoiceCoordinator) {
//            self.coordinator = coordinator
//        }
    
    
    func done() {
        result.send(.done)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}
