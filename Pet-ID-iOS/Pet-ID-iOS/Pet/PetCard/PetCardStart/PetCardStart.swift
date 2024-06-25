import SwiftUI

struct PetCardStart: View {
    @State private var isNextScreenPresented = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                Text("펫 아이디 만들기를 시작합니다")
                    .font(.system(size: 24))
                    .padding()
                Text("반려동물 등록이 필요해요")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                Spacer()
                
                Image(systemName: "pencil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                NavigationLink(destination: PetInfo().navigationBarBackButtonHidden(), isActive: $isNextScreenPresented) {
                    EmptyView()
                }
                .navigationBarHidden(true)
                .padding(.horizontal)
                
                Button(action: {
                    isNextScreenPresented = true
                }) {
                    Text("시작하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                Button {
                    // 이미 등록되어 있어요 버튼 액션 추가
                } label: {
                    Text("이미 등록되어 있어요")
                        .foregroundColor(.gray)
                }
            }
            .padding()
//            .navigationBarBackButtonHidden()
        }
    }
}

struct PetCardStart_Previews: PreviewProvider {
    static var previews: some View {
        PetCardStart()
    }
}
