import SwiftUI

struct RegistrationInfo: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var name: String = ""
    @State private var number: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text("반려동물 등록 정보를")
                    Text("가져올게요.")
                }
                .font(.system(size: 24, weight: .bold))
                .padding()
                
                Group {
                    Text("소유주 이름")
                        .padding()
                    TextField("이름을 입력해 주세요.", text: $name)
                        .padding()
                }
                
                
                Group {
                    Text("반려동물 등록번호")
                        .padding()
                    TextField("번호를 입력해 주세요.", text: $number)
                        .padding()
                }
                
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
                
            }
            .padding()
            .navigationBarHidden(true)
            
            

        }
    }
}

#Preview {
    RegistrationInfo()
}
