import SwiftUI

struct PetCaption: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
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
                Text("반려동물의 사진을")
                    .font(.system(size: 24))
                Text("추가해주세요.")
                    .font(.system(size: 24))
                Text("정보가 자동으로 입력됩니다.")
                    .foregroundColor(.gray)
            }
            .padding()
            
            Image(systemName: "pencil")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "1.circle")
                    Text("반려동물의 사진을 찍어주세요.")
                }
                HStack {
                    Image(systemName: "2.circle")
                    HStack(spacing: 0) {
                        Text("촬영 시작 버튼")
                            .foregroundColor(.blue)
                        Text("을 누르면 가이드가 나와요.")
                    }
                }
                HStack {
                    Image(systemName: "3.circle")
                    Text("스캔한 정보가 자동으로 입력됩니다.")
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                // 여기에 완료 버튼 액션을 추가하세요
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
    PetCaption()
}
