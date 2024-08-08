import SwiftUI

struct PetCardStart: View {
    @ObservedObject var viewModel: PetCardStartViewModel
    var coordinator: PetCardStartCoordinator
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    viewModel.navigateBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("1/7")
                    .font(.petIdTitle1)
                    .foregroundColor(.petid_clearblue)
                
                Text("펫 아이디 만들기를 \n시작합니다")
                    .font(.petIdTitle1)
                
                Text("회원님의 상태를 선택하세요")
                    .font(.petIdBody2)
                    .foregroundColor(.petid_gray)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Button(action: {
                        viewModel.selectState(.unregistered)
                    }) {
                        Text("반려동물 등록을 하지 않았어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_lightgray)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.selectState(.externalChip)
                    }) {
                        Text("외장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_lightgray)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        viewModel.selectState(.internalChip)
                    }) {
                        Text("내장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.petid_lightgray)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                }
                .font(.petIdBody1)
                .padding(.top, -100)
                
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    PetCardStart(viewModel: PetCardStartViewModel(), coordinator: PetCardStartCoordinator(navigationController: UINavigationController()))
}
