import SwiftUI

struct PetCardStart: View {
    @ObservedObject var viewModel: PetCardStartViewModel
    var coordinator: PetCardStartCoordinator
    
    var body: some View {
        VStack(alignment: .leading) {
            // 상단 네비게이션 버튼
            HStack {
                Button(action: {
                    coordinator.navigateBack()
                }) {
                    DSImage.chevronicon.toImage()
                        .font(.title2)
                        .foregroundColor(.petid_title)
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                // 진행 단계 및 안내 텍스트
                Text("1/7")
                    .font(.body1_bold)
                    .foregroundColor(.petid_clearblue)
                
                Text("펫 아이디 만들기를 \n시작합니다")
                    .font(.headline1)
                
                Text("회원님의 상태를 선택하세요")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
                
                Spacer()
                
                // 선택 버튼들
                VStack(spacing: 15) {
                    Button(action: {
                        viewModel.selectChipType(.unregistered)
                    }) {
                        Text("반려동물 등록을 하지 않았어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.selectedState == .unregistered ? Color.petid_clearblue : Color.petid_f2)
                            .foregroundColor(viewModel.selectedState == .unregistered ? .white : .petid_title)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.selectChipType(.externalChip)
                    }) {
                        Text("외장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.selectedState == .externalChip ? Color.petid_clearblue : Color.petid_f2)
                            .foregroundColor(viewModel.selectedState == .externalChip ? .white : .petid_title)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.selectChipType(.internalChip)
                    }) {
                        Text("내장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.selectedState == .internalChip ? Color.petid_clearblue : Color.petid_f2)
                            .foregroundColor(viewModel.selectedState == .internalChip ? .white : .petid_title)
                            .cornerRadius(10)
                    }
                }
                .font(.body2_med)
                .padding(.top, -50)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            Button(action: {
                Logger().debug("사용자가 선택한 상태: \(viewModel.selectedState?.rawValue ?? "선택 없음")")
                 viewModel.handleNextAction()
//                    coordinator.navigateToUserInfo()
                
                
            }) {
                Text("다음")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.selectedState == nil ? Color.petid_b4 : Color.petid_clearblue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.selectedState == nil) // 선택이 없으면 버튼 비활성화
            .padding()
        }
        .padding()
    }
}

#Preview {
    PetCardStart(viewModel: PetCardStartViewModel(), coordinator: PetCardStartCoordinator(UINavigationController()))
}
