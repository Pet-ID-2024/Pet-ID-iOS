import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            // TabView
            TabView(selection: $viewModel.currentPage) {
                OnboardingFirstView
                    .tag(0)
                
                OnboardingSecondView
                    .tag(1)
                
                OnboardingThirdView
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // 기본 인디케이터 숨기기
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // 커스텀 인디케이터
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.totalPages, id: \.self) { index in
                        Circle()
                            .fill(index == viewModel.currentPage ? Color.black : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 70) // 인디케이터 위치 조정
                
                // 버튼 (마지막 뷰에만 표시)
                if viewModel.onboardingCompleted {
                    Button(action: {
                        viewModel.nextPage()
                    }) {
                        Text("시작하기")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.petid_clearblue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20) // 버튼 위치 조정
                }
            }
        }
        .navigationBarHidden(true) // 네비게이션 바 숨김
        .navigationBarBackButtonHidden(true) // 네비게이션 뒤로 가기 버튼 숨김
    }
    
    var OnboardingFirstView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                DSImage.onboardingicon1.toImage()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 177, height: 273)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("손안에 담긴\n특별한 카드")
                    .font(.splash1_semi)
                    .foregroundColor(.petid_title)
                    .multilineTextAlignment(.leading)
                
                Text("모바일 펫 카드에서\n반려동물 정보를 쉽게 볼 수 있어요")
                    .font(.headline3_reg)
                    .foregroundColor(.petid_title)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .padding()
    }
    
    var OnboardingSecondView: some View {
        VStack(alignment: .leading, spacing: 36) {
            HStack {
                Spacer()
                DSImage.onboardingicon2.toImage()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 241, height: 240)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("반려동물과의 첫걸음\n안전한 등록")
                    .font(.splash1_semi)
                    .foregroundColor(.petid_title)
                    .multilineTextAlignment(.leading)
                
                Text("내 주변 등록대행 병원 확인하고\n간편 예약해 보세요")
                    .font(.headline3_reg)
                    .foregroundColor(.petid_title)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
        .padding()
    }
    
    var OnboardingThirdView: some View {
        VStack(alignment: .leading, spacing: 0) {
//            Spacer()
            HStack {
                Spacer()
                DSImage.onboardingicon3.toImage()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 375)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("AI 인식\n간편 정보입력")
                    .font(.splash1_semi)
                    .foregroundColor(.petid_title)
                    .multilineTextAlignment(.leading)
                
                Text("반려동물 사진으로\n빠르게 정보를 작성해 보세요")
                    .font(.headline3_reg)
                    .foregroundColor(.petid_title)
                    .multilineTextAlignment(.leading)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: OnboardingViewModel())
    }
}
