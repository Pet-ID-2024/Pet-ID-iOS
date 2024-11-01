import SwiftUI

struct ReservationDetailView: View {
    @ObservedObject var viewModel: ReservationDetailViewModel
    var body: some View {
        VStack (alignment: .leading){
            // Header
            HStack {
                Button(action: {
                    viewModel.navigateBack()
                }) {
                    DSImage.chevronicon.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                }
                
                .padding(.leading, 5)
                Spacer()
                Text("도그마루 동물병원")
                    .font(.body2_reg)
                    .foregroundColor(.petid_title)
                    .padding(.trailing, 23)
                Spacer()
                
            }
            .padding()
        }
            // 병원 이미지
            Rectangle() // 이미지 파일을 프로젝트에 추가하세요.
//                .resizable()
//                .aspectRatio(contentMode: .fit)
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            Circle() // 페이지 인디케이터
                                .fill(Color.blue)
                                .frame(width: 8, height: 8)
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 8, height: 8)
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 8, height: 8)
                        }
                        .padding(.bottom, 10)
                    }
                )
        VStack(alignment:.leading){
            // 병원 정보
            VStack(alignment: .leading, spacing: 20) {
                Text("도그마루 동물병원")
                    .font(.headline3_bold)
                    .foregroundColor(.petid_title)
                
                HStack {
                    DSImage.personicon.toImage()
                    Text("홍길동 원장")
                        .font(.body3_med)
                        .foregroundColor(.petid_subtitle)
                }
                
                HStack {
                    DSImage.timeicon.toImage()
                    Text("10:00 - 20:00 (13:00 - 14:00 휴게시간)")
                        .font(.body3_med)
                        .foregroundColor(.petid_subtitle)
                }
                
                HStack {
                    DSImage.placeicon.toImage()
                    Text("서울 송파구 송파대로11길 1-1 A동 1층")
                        .font(.body3_med)
                        .foregroundColor(.petid_subtitle)
                }
                
                HStack {
                    DSImage.rscallicon.toImage()
                    Text("02-123-1234")
                        .font(.body3_med)
                        .foregroundColor(.petid_subtitle)
                }
            }
            .padding()
            
            Spacer()
            
            // 예약 버튼
            Button(action: {
                viewModel.reservation()
            }) {
                Text("방문 날짜/시간 예약하기")
                    .font(.body2_med)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.petid_clearblue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
//                Text("촬영 시작")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.petid_clearblue)
//                    .foregroundColor(.white)
//                    .font(.body2_med)
//                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
        .navigationBarHidden(true) // 커스텀 헤더를 사용하기 위해 네비게이션 바 숨김
    }
}

#Preview {
    ReservationDetailView(viewModel: ReservationDetailViewModel())
}
