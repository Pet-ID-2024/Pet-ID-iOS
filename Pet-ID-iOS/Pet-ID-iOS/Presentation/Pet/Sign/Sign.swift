import SwiftUI

struct Sign: View {
    @ObservedObject var viewModel: SignViewModel
    var coordinator: SignCoordinator
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("마지막")
                    .foregroundColor(.petid_clearblue)
                    .font(.petIdTitle2)
                
                Text("마지막으로 \n서명을 해주세요")
                    .font(.petIdTitle1)
                
                
                Text("반려동물등록 신청에 서명이 필요해요")
                    .foregroundColor(.petid_gray)
                    .font(.petIdBody2)
            }
            .padding()
            
            HStack{
                Spacer()
                SignatureView(lines: $viewModel.lines)
                    .frame(width: 330, height: 300)
                    .background(Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.vertical)
                Spacer()
            }
            
            Spacer()
            
            Button {
                viewModel.navigateToPCD()
            } label: {
                Text("다음")
                    .foregroundColor(.petid_white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.petid_clearblue)
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .padding()
        
    }
}


#Preview {
    Sign(viewModel: SignViewModel(), coordinator: SignCoordinator(navigationController: UINavigationController()))
}
