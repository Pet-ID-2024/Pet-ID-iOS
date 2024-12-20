
import Foundation
import Combine

enum ReservationChoiceState: String {
    case done
    case back
}

class ReservationChoiceViewModel: BaseViewModel<ReservationChoiceState> {
    @Published var selectedDate: Date? /*= nil*/
    @Published var selectedTime: String? /*= nil*/
    @Published var availableTimes: [String] = []
    @Published var isHoliday: Bool = false
    
    
    let hospital: Hospital
    private let reservationTimeFetcher: ReservationTimeFetcher
    private let holidayFetcher: HolidayFetcher
    private let reservationListFetcher: ReservationListFetcher
    
    init(
        hospital: Hospital,
        reservationTimeFetcher: ReservationTimeFetcher = DefaultReservationTimeFetcher(),
        holidayFetcher: HolidayFetcher = DefaultHolidayFetcher(),
        reservationListFetcher: ReservationListFetcher = DefaultReservationListFetcher()
    ) {
        self.hospital = hospital
        self.reservationTimeFetcher = reservationTimeFetcher
        self.holidayFetcher = holidayFetcher
        self.reservationListFetcher = reservationListFetcher
        super.init()
    }
    
    func fetchAvailableTimes(for date: Date) {
        let dayOfWeek = date.getDayOfWeek()
        let formattedDate = DateFormatter.petInfoDateFormatter.string(from: date)
        
        Task {
            do {
                // 선택된 날짜의 휴무 여부를 먼저 확인
                let holidayStatus = try await holidayFetcher.checkHoliday(holidayId: hospital.id, day: dayOfWeek)
                
                // 메인 스레드에서 휴무일 상태 업데이트
                DispatchQueue.main.async {
                    self.isHoliday = holidayStatus
                    //                    self.availableTimes = [] // 기본적으로 예약 가능 시간 초기화
                    if holidayStatus {
                        self.availableTimes = []
                    }
                }
                
                // 만약 휴무일이 아닌 경우에만 예약 가능한 시간 조회
                if !holidayStatus {
                    let times = try await reservationTimeFetcher.availableTimes(
                        hospitalId: hospital.id,
                        day: dayOfWeek,
                        date: formattedDate
                    )
                    //                    Logger().debug("✅ 예약 가능 시간 조회 성공: \(times)")
                    
                    // 메인 스레드에서 availableTimes 업데이트
                    DispatchQueue.main.async {
                        self.availableTimes = times
                    }
                } else {
                    //                    Logger().debug("🚫 선택한 날짜는 휴무일입니다.")
                }
                
            } catch {
                Logger().error("❌ 예약 가능 시간 또는 휴무일 확인 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func createReservation() {
        guard let selectedDate = selectedDate, let selectedTime = selectedTime else {
            Logger().error("❌ 예약 정보를 선택하지 않았습니다.")
            return
        }
        
        guard let combinedDate = selectedDate.combine(with: selectedTime) else {
            Logger().error("❌ 예약 날짜와 시간 결합 실패")
            return
        }
        
        let request = CreateReservationRequestDTO(hospitalId: hospital.id, date: combinedDate)
        
        print("📩 Sending Request: Hospital ID: \(hospital.id), Date: \(combinedDate)")
        
        Task {
            do {
                let response = try await reservationListFetcher.createReservation(request: request)
                Logger().debug("✅ 예약 생성 성공: \(response)")
                
                DispatchQueue.main.async {
                    self.result.send(.done)
                }
            } catch {
                Logger().error("❌ 예약 생성 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func done() {
        result.send(.done)
    }
    
    func navigateBack() {
        result.send(.back)
    }
}

extension Date {
    func getDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).uppercased()
    }
    
    func combine(with time: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = "\(DateFormatter.petInfoDateFormatter.string(from: self)) \(time)"
        return dateFormatter.date(from: dateString)
    }
}

extension DateFormatter {
    static let reservationISO8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
