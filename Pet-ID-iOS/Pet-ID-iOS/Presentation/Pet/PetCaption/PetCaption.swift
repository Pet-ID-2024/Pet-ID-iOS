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
                    .font(.petIdTitle1)
                    .foregroundColor(.petid_clearblue)
                Text("반려동물 \n사진 촬영을 시작할게요")
                    .font(.petIdTitle1)
                Text("AI가 반려동물의 정보를 가져올거에요!")
                    .font(.petIdBody2)
                    .foregroundColor(.petid_gray)
            }
            .padding()
            
            Spacer()
            
            DSImage.captionicon.toImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 360, height: 300)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            VStack {
                Text("가이드에 맞춰서 \n사진촬영을 해주세요!")
                    .font(.petIdTitle3)
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
                    .background(Color.petid_clearblue)
                    .foregroundColor(.petid_white)
                    .font(.petIdBody1)
                    .cornerRadius(8)
            }
        }
        .navigationBarHidden(true)
        .padding()
    }
}

#Preview {
    PetCaption(viewModel: PetCaptionViewModel(), coordinator: PetCaptionCoordinator(navigationController: UINavigationController()))
}
