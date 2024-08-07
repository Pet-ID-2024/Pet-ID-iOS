import SwiftUI

struct PetCaption: View {
    @ObservedObject var viewModel: PetCaptionViewModel
    var coordinator: PetCaptionCoordinator
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    coordinator.navigateBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("4/7")
                Text("반려동물 \n사진 촬영을 시작할게요")
                Text("AI가 반려동물의 정보를 가져올거에요!")
            }
            .padding()
            
            Image(systemName: "pencil")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack {
                Text("가이드에 맞춰서 \n사진촬영을 해주세요!")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                viewModel.navigateToCamera()
            }) {
                Text("촬영 시작")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationBarBackButtonHidden(true) // 뒤로 가기 버튼 숨기기
        .padding()
    }
}

#Preview {
    PetCaption(viewModel: PetCaptionViewModel(), coordinator: PetCaptionCoordinator(navigationController: UINavigationController()))
}
