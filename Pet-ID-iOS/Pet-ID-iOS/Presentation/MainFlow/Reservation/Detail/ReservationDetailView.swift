import SwiftUI
import Kingfisher

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
                Text(viewModel.hospital.name)
                    .font(.body2_reg)
                    .foregroundColor(.petid_title)
                    .padding(.trailing, 23)
                Spacer()
                
            }
            .padding()
        }
        // 병원 이미지
        GeometryReader { geometry in
            if !viewModel.processedImageUrls.isEmpty {
                TabView {
                    ForEach(viewModel.processedImageUrls, id: \.self) { urlString in
                        KFImage(URL(string: urlString))
                            .resizable()
                            .scaledToFill() // 화면에 꽉 차도록 이미지 비율 조정
                            .frame(width: geometry.size.width, height: geometry.size.height) // 화면 크기와 동일한 크기
                            .clipped() // 넘치는 부분 잘라내기
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            } else {
                // 기본 이미지 표시
                DSImage.noimageicon.toImage()
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
        }
        
        VStack(alignment:.leading){
            // 병원 정보
            VStack(alignment: .leading, spacing: 20) {
                Text(viewModel.hospital.name)
                    .font(.headline3_bold)
                    .foregroundColor(.petid_title)
                
                HStack {
                    DSImage.personicon.toImage()
                    Text("\(viewModel.hospital.vet) 원장")
                        .font(.body3_med)
                        .foregroundColor(.petid_subtitle)
                }
                
                HStack {
                    DSImage.timeicon.toImage()
                    Text(viewModel.hospital.hours ?? "정보없음")
                        .font(.body3_med)
                        .foregroundColor(.petid_subtitle)
                }
                
                HStack {
                    DSImage.placeicon.toImage()
                    Text(viewModel.hospital.address)
                    //                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .font(.body3_med)
                        .foregroundColor(.petid_subtitle)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                HStack {
                    DSImage.rscallicon.toImage()
                    Text(viewModel.hospital.tel)
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
                
                
            }
            .padding()
        }
        .padding()
        .navigationBarHidden(true) // 커스텀 헤더를 사용하기 위해 네비게이션 바 숨김
    }
}

#Preview {
    let sampleHospital = Hospital(
        id: 1,
        imageUrl: ["https://example.com/image.png"], // 샘플 이미지 URL
        address: "서울 송파구 송파대로11길 1-1 A동 1층",
        name: "도그마루 동물병원",
        hours: "10:00 - 20:00 (13:00 - 14:00 휴게시간)",
        tel: "02-123-1234",
        vet: "홍길동 원장"
    )
    
    let viewModel = ReservationDetailViewModel(hospital: sampleHospital)
    
    return ReservationDetailView(viewModel: viewModel)
}
