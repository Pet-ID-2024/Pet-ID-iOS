import SwiftUI

struct CalendarView: View {
    @State private var currentMonth = Calendar.current.component(.month, from: Date())
    @State private var currentYear = Calendar.current.component(.year, from: Date())
    @Binding var selectedDate: Date? // Optional로 변경하여 선택되지 않은 상태 지원
    
    let today = Calendar.current.component(.day, from: Date()) // 오늘의 날짜
    let currentDay = Calendar.current.component(.day, from: Date())
    let currentCalendarMonth = Calendar.current.component(.month, from: Date()) // 오늘의 달
    let currentCalendarYear = Calendar.current.component(.year, from: Date()) // 오늘의 연도
    
    let days = ["월", "화", "수", "목", "금", "토", "일"]
    let startMonth = Calendar.current.component(.month, from: Date()) // 시작하는 달
    let startYear = Calendar.current.component(.year, from: Date()) // 시작하는 연도
    
    // 각 월에 맞는 날짜 수를 반환하는 함수
    private func numberOfDays(in month: Int, year: Int) -> Int {
        let isLeapYear = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
        switch month {
        case 2: return isLeapYear ? 29 : 28
        case 4, 6, 9, 11: return 30
        default: return 31
        }
    }
    
    // 첫 번째 날의 요일을 반환하는 함수
    private func firstWeekdayOfMonth(month: Int, year: Int) -> Int {
        let components = DateComponents(year: year, month: month, day: 1)
        guard let date = Calendar.current.date(from: components) else { return 0 }
        let weekday = Calendar.current.component(.weekday, from: date)
        return (weekday + 5) % 7 // 0: 월요일, 6: 일요일
    }
    
    // 이전 달의 날짜를 가져오는 함수
    private func previousMonthDates() -> [Int] {
        let previousMonth = currentMonth == 1 ? 12 : currentMonth - 1
        let previousYear = currentMonth == 1 ? currentYear - 1 : currentYear
        let previousMonthDays = numberOfDays(in: previousMonth, year: previousYear)
        let firstWeekday = firstWeekdayOfMonth(month: currentMonth, year: currentYear)
        
        let start = max(previousMonthDays - firstWeekday + 1, 1)
        
        if start <= previousMonthDays {
            return Array(start...previousMonthDays)
        } else {
            return [] // 유효하지 않은 경우 빈 배열 반환
        }
    }
    
    // 다음 달의 날짜를 가져오는 함수
    private func nextMonthDates(currentDaysCount: Int) -> [Int] {
        let totalCells = 42
        let remainingCells = totalCells - currentDaysCount
        return remainingCells > 0 ? Array(1...remainingCells) : []
    }
    
    var body: some View {
        VStack(spacing: 15) {
            // 월 및 연도 표시 부분
            monthYearHeader
            
            // 요일 표시 부분
            daysHeader
            
            // 날짜 표시 부분
            datesGrid
            
            Spacer()
        }
        .padding(.top, 16)
        .background(Color.petid_f5)
        .cornerRadius(20)
        .padding(16)
    }
    
    private var monthYearHeader: some View {
        HStack {
            Spacer()
            
            Button(action: previousMonth) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.petid_gray)
            }
            .frame(width: 32)
            .opacity(currentMonth == startMonth && currentYear == startYear ? 0 : 1)
            
            Spacer(minLength: 0)
            
            Text("\(String(currentCalendarYear))년 \(currentMonth)월")
                .font(.body1_med)
                .foregroundColor(.petid_title)
                .frame(minWidth: 50)
                .padding(.horizontal, 10)
            
            Spacer(minLength: 0)
            
            Button(action: nextMonth) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.petid_gray)
            }
            .frame(width: 32)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
    }
    
    private var daysHeader: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.body3_reg)
                    .foregroundColor(.petid_gray)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var datesGrid: some View {
        let previousDates = previousMonthDates()
        let numberOfDaysInMonth = numberOfDays(in: currentMonth, year: currentYear)
        let currentDaysCount = previousDates.count + numberOfDaysInMonth
        let totalCells = currentDaysCount > 35 ? 42 : 35
        
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
            // 이전 달 날짜 표시
            ForEach(previousDates.indices, id: \.self) { index in
                Text("\(previousDates[index])")
                    .font(.body2_med)
                    .foregroundColor(.petid_lightgray)
                    .frame(width: 32, height: 32)
                    .id("prev-\(currentYear)-\(currentMonth-1)-\(previousDates[index])")
            }
            
            // 현재 월에 맞는 날짜 표시
            ForEach(1...numberOfDaysInMonth, id: \.self) { date in
                dateCell(for: date)
                    .id("current-\(currentYear)-\(currentMonth)-\(date)")
            }
            
            let remainingCells = totalCells - currentDaysCount
            if remainingCells > 0 {
                ForEach(1...remainingCells, id: \.self) { date in
                    Text("\(date)")
                        .font(.body2_med)
                        .foregroundColor(.petid_lightgray)
                        .frame(width: 32, height: 32)
                        .id("next-\(currentYear)-\(currentMonth+1)-\(date)")
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func dateCell(for date: Int) -> some View {
        let isToday = date == currentDay && currentMonth == currentCalendarMonth && currentYear == currentCalendarYear
        let isWithinWeek = isWithinAWeek(from: date)

        return ZStack {
            if let selectedDay = Calendar.current.date(from: DateComponents(year: currentYear, month: currentMonth, day: date)),
               selectedDate != nil && Calendar.current.isDate(selectedDate!, inSameDayAs: selectedDay) {
                Circle()
                    .fill(Color.petid_clearblue)
                    .frame(width: 32, height: 32)
                    .overlay(
                        ZStack {
                            DSImage.calendaricon.toImage()
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                            
                            Text("\(date)")
                                .font(.body2_med)
                                .foregroundColor(.white)
                        }
                    )
            } else if isToday {
                Text("\(date)")
                    .font(.body2_med)
                    .foregroundColor(.petid_clearblue)
                    .frame(width: 32, height: 32)
            } else if isWithinWeek {
                Text("\(date)")
                    .font(.body2_med)
                    .foregroundColor(.petid_title)
                    .frame(width: 32, height: 32)
            } else {
                Text("\(date)")
                    .font(.body2_med)
                    .foregroundColor(.petid_subtitle)
                    .frame(width: 32, height: 32)
            }
        }
        .onTapGesture {
            // 일주일 이내 날짜만 클릭 가능하며, 오늘 날짜는 클릭 불가
            if !isToday && isWithinWeek {
                if let selected = Calendar.current.date(from: DateComponents(year: currentYear, month: currentMonth, day: date)) {
                    DispatchQueue.main.async {
                        self.selectedDate = selected
                    }
                }
            }
        }
        .frame(width: 32, height: 32)
    }
    
    private func isWithinAWeek(from day: Int) -> Bool {
        guard let currentDate = Calendar.current.date(from: DateComponents(year: currentYear, month: currentMonth, day: day)) else { return false }
        
        let today = Calendar.current.date(from: DateComponents(year: currentCalendarYear, month: currentCalendarMonth, day: currentDay))!
        
        if let weekLater = Calendar.current.date(byAdding: .day, value: 7, to: today) {
            return (today...weekLater).contains(currentDate)
        }
        
        return false
    }
    
    private func nextMonth() {
        if currentMonth < 12 {
            currentMonth += 1
        } else {
            currentMonth = 1
            currentYear += 1
        }
        selectedDate = nil // 새로운 달로 이동할 때 선택된 날짜 초기화
    }
    
    private func previousMonth() {
        if currentMonth > 1 {
            currentMonth -= 1
        } else {
            currentMonth = 12
            currentYear -= 1
        }
        selectedDate = nil // 새로운 달로 이동할 때 선택된 날짜 초기화
    }
}



#Preview {
    @State var selectedDate: Date? = nil
    
    return CalendarView(selectedDate: $selectedDate)
}
