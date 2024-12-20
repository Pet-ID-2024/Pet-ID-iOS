import SwiftUI

struct ReservationChoiceView: View {
    @ObservedObject var viewModel: ReservationChoiceViewModel
    
    var body: some View {
        VStack {
            // 헤더
            HStack {
                Button(action: {
                    viewModel.navigateBack()
                }) {
                    DSImage.chevronicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                }
                .padding(.leading, 15)
                Spacer()
                Text(viewModel.hospital.name)
                    .font(.body2_reg)
                    .foregroundColor(.petid_title)
                    .padding(.trailing, 25)
                Spacer()
            }
            .padding()
            
            ScrollView {
                // 방문 일시
                VStack(alignment: .leading, spacing: 8) {
                    Text("방문 일시")
                        .font(.headline3_med)
                        .foregroundColor(.petid_title)
                        .padding(.leading)
                    
                    Text("오늘을 제외한 7일 이내의 날짜만 선택 가능합니다.")
                        .font(.body3_reg)
                        .foregroundColor(.petid_subtitle)
                        .padding(.leading)
                    
                    CalendarView(selectedDate: $viewModel.selectedDate)
                    
                }
                
                if viewModel.selectedDate != nil {
                    if viewModel.isHoliday {
                        holiday
                    } else {
                        Reservation
                    }// 예약 가능한 시간이 렌더링됨
                } else {
                    choice // 날짜 선택을 유도하는 뷰
                }
                
                Spacer()
                
                // 예약 완료 버튼
                if viewModel.selectedDate == nil || viewModel.isHoliday {
                    
                } else {
                    Button {
                        viewModel.createReservation()
                    } label: {
                        Text("예약 완료하기")
                            .font(.body2_med)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.selectedTime != nil ? Color.petid_clearblue : Color.petid_f5)
                            .foregroundColor(viewModel.selectedTime != nil ? .white : .petid_subtitle)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(viewModel.selectedTime == nil)
                    
                    
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
        .onChange(of: viewModel.selectedDate) { newDate in
            if let date = newDate {
                viewModel.fetchAvailableTimes(for: date) // 선택된 날짜가 있을 때만 호출
            }
        }
    }
    
    // 예약 가능한 시간을 오전/오후로 나누어 배열을 반환하는 메서드
    private func splitTimesIntoMorningAndAfternoon() -> ([String], [String]) {
        let morningTimes = viewModel.availableTimes.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            return hour < 12
        }
        
        let afternoonTimes = viewModel.availableTimes.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            return hour >= 12
        }
        
        return (morningTimes, afternoonTimes)
    }
    
    // 시간을 선택할 수 있는 버튼을 그리드 형식으로 제공하는 함수
    private func timeGridView(times: [String]) -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
        return LazyVGrid(columns: columns, spacing: 15) {
            ForEach(Array(times.enumerated()), id: \.offset) { index, time in
                Button(action: {
                    viewModel.selectedTime = time
                }) {
                    Text(time)
                        .font(.subheadline)
                        .frame(width: 100, height: 40)
                        .background(viewModel.selectedTime == time ? Color.petid_clearblue : Color.white)
                        .foregroundColor(viewModel.selectedTime == time ? .white : .petid_title)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(viewModel.selectedTime == time ? Color.petid_clearblue : Color.petid_e9, lineWidth: 1)
                        )
                }
            }
        }
    }
    
    var holiday: some View {
        VStack(alignment: .leading) {
            Text("동물병원 휴일")
                .font(.headline3_med)
                .foregroundColor(.petid_title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("휴일에는 서비스를 운영하지 않아요.\n다른 날짜를 확인해 주세요!")
                .font(.body3_reg)
                .foregroundColor(.petid_under_bar)
                .padding(.horizontal)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(Color.petid_f5)
                .cornerRadius(10)
        }
        .padding(.top, 20)
        .padding(.horizontal)
    }
    
    var choice: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("예약가능 시간")
                .font(.headline3_med)
                .foregroundColor(.petid_title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("날짜를 먼저 선택해주세요")
                .font(.body3_reg)
                .foregroundColor(.petid_under_bar)
                .padding(.horizontal)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, minHeight: 80)
                .background(Color.petid_f5)
                .cornerRadius(10)
        }
        .padding(.top, 20)
        .padding(.horizontal)
    }
    
    var Reservation: some View {
        // 예약 가능한 시간
        VStack(alignment: .leading, spacing: 8) {
            Text("예약가능 시간")
                .font(.headline3_med)
                .foregroundColor(.petid_title)
                .padding(.leading)
            
            // 오전과 오후 시간 분리
            let (morningTimes, afternoonTimes) = splitTimesIntoMorningAndAfternoon()
            
            // 오전 시간
            Text("오전")
                .font(.body3_med)
                .foregroundColor(.petid_under_bar)
                .padding(.leading)
                .padding(.top, 10)
            
            timeGridView(times: morningTimes)
                .padding(.horizontal)
            
            // 오후 시간
            Text("오후")
                .font(.body3_med)
                .foregroundColor(.petid_under_bar)
                .padding(.leading)
                .padding(.top, 10)
            
            timeGridView(times: afternoonTimes)
                .padding(.horizontal)
        }
        .padding(.top, 20)
    }
}

#Preview {
    ReservationChoiceView(viewModel: ReservationChoiceViewModel(hospital: Hospital(id: 2, imageUrl: [], address: "2", name: "s", hours: "4", tel: "5", vet: "6")))
}
