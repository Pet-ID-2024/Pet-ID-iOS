import SwiftUI

struct ScanCheck: View {
    @ObservedObject var viewModel: ScanCheckViewModel
    var coordinator: ScanCheckCoordinator
    
    @State private var navigateToInformationCheck = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        viewModel.navigateBack()
                    }) {
                        DSImage.chevronicon.toImage()
                            .font(.petIdChevron)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 10){
                    Text("5/7")
                        .font(.petIdTitle2)
                        .foregroundColor(.petid_clearblue)
                    
                    Text("반려동물 정보를 가져왔어요!")
                        .font(.petIdTitle1)
                    
                    Text("잘못된 정보는 수정할 수 있어요")
                        .foregroundColor(.petid_gray)
                        .font(.petIdBody2)
                }
                
                
                VStack(spacing: 30) {
                    InputField(title: "품종", text: $viewModel.productType)
                    InputField(title: "털 색깔", text: $viewModel.furColor)
                    InputField(title: "특징", text: $viewModel.furFeatures)
                    InputField(title: "몸무게", text: $viewModel.bodyWeight)
                }
                .padding(.top, 40)
                
                
                Spacer()
                
                Button {
                    viewModel.navigateToIC()
                    
                } label: {
                    Text("다음")
                        .foregroundColor(.petid_white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.petid_clearblue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
    }
}

struct ScanCheck_Previews: PreviewProvider {
    static var previews: some View {
        ScanCheck(viewModel: ScanCheckViewModel(image: UIImage()), coordinator: ScanCheckCoordinator(navigationController: UINavigationController(), image: UIImage()))
    }
}
