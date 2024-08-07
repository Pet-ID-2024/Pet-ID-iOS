import SwiftUI

struct PetCardStart: View {
    @ObservedObject var viewModel: PetCardStartViewModel
    var coordinator: PetCardStartCoordinator
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    print("Back button pressed in PetCardStart view")
                    viewModel.navigateBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("1/7")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text("펫 아이디 만들기를 시작합니다")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("회원님의 상태를 선택하세요")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Button(action: {
                        print("Unregistered button pressed")
                        viewModel.selectState(.unregistered)
                        coordinator.navigateToUserInfo()
                    }) {
                        Text("반려동물 등록을 하지 않았어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        print("External Chip button pressed")
                        viewModel.selectState(.externalChip)
                        coordinator.navigateToUserInfo()
                    }) {
                        Text("외장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        print("Internal Chip button pressed")
                        viewModel.selectState(.internalChip)
                        coordinator.navigateToUserInfo()
                    }) {
                        Text("내장칩 등록이 되어있어요")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                }
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
