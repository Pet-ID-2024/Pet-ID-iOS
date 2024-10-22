import SwiftUI

struct ReservationChoiceView: View {
    @ObservedObject var viewModel: ReservationChoiceViewModel
    
    var body: some View {
        // ScrollView로 감싸기
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
                Text("도그마루 동물병원")
                    .font(.body2_reg)
                    .foregroundColor(.petid_title)
                    .padding(.trailing, 25)
                Spacer()
//                Spacer() // 가운데 정렬을 위해 추가
            }
            .padding()
            
            ScrollView{
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
                    
                    CalendarView()
                }
                
//                Spacer()
                
                
                nal
                
                Spacer()
                
                // 예약 완료 버튼
                Button(action: {
                    viewModel.done()
                }) {
                    Text("예약 완료하기")
                        .font(.body2_med)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.petid_clearblue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                //                .padding(.horizontal)
                //                .padding(.bottom)
                .padding()
            }
            .padding()
            .navigationBarHidden(true) // 커스텀 헤더를 사용하기 위해 네비게이션 바 숨김
        }
        
    }
    
    // 시간을 선택할 수 있는 버튼을 그리드 형식으로 제공하는 함수
    private func timeGridView(times: [String]) -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
        return LazyVGrid(columns: columns, spacing: 15) {
            ForEach(times, id: \.self) { time in
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
    
    var nal: some View {
        // 예약 가능한 시간
        VStack(alignment: .leading, spacing: 8) {
            Text("예약 가능한 시간")
                .font(.headline3_med)
                .foregroundColor(.petid_title)
                .padding(.leading)
            
            // 오전
            Text("오전")
                .font(.body3_med)
                .foregroundColor(.petid_under_bar)
                .padding(.leading)
                .padding(.top, 10)
            
            timeGridView(times: viewModel.availableTimesMorning)
                .padding(.horizontal)
            
            // 오후
            Text("오후")
                .font(.body3_med)
                .foregroundColor(.petid_under_bar)
                .padding(.leading)
                .padding(.top, 10)
            
            timeGridView(times: viewModel.availableTimesAfternoon)
                .padding(.horizontal)
        }
        .padding(.top, 60)
    }
    
}

#Preview {
    ReservationChoiceView(viewModel: ReservationChoiceViewModel())
}
