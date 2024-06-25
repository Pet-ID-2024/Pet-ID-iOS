import SwiftUI

struct LoginSuccess: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            VStack {
                Text("펫아이디 회원가입을\n     축하드립니다.")
                    .font(.system(size: 28))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                
                Image("CheckImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Spacer()
                
                Button(action: {
                    // 여기에 완료 버튼 액션을 추가하세요
                }) {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginSuccess()
}
