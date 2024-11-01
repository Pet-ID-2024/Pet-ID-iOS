import SwiftUI

struct PetCardStart: View {
    @ObservedObject var viewModel: PetCardStartViewModel
    var coordinator: PetCardStartCoordinator
    
    var body: some View {
        VStack(alignment: .leading) {
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
            //            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("1/7")
                    .font(.body1_bold)
                    .foregroundColor(.petid_clearblue)
                
                Text("펫 아이디 만들기를 \n시작합니다")
                    .font(.headline1)
                
                Text("회원님의 상태를 선택하세요")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Button(action: {
                        viewModel.selectState(.unregistered)
                        //                        coordinator.navigateToUserInfo()
                    }) {
                        Text("반려동물 등록을 하지 않았어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_f2)
                            .foregroundColor(.petid_title)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.selectState(.externalChip)
                    }) {
                        Text("외장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_f2)
                            .foregroundColor(.petid_title)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.selectState(.internalChip)
                    }) {
                        Text("내장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_f2)
                            .foregroundColor(.petid_title)
                            .cornerRadius(10)
                    }
                }
                .font(.body2_med)
                .padding(.top, -100)
                
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    PetCardStart(viewModel: PetCardStartViewModel(), coordinator: PetCardStartCoordinator(UINavigationController()))
}
