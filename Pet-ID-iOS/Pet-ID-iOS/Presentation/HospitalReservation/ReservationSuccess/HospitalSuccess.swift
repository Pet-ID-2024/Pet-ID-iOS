import SwiftUI

struct HospitalSuccess: View {
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
                            .padding()
                    }
                    Spacer()
                }
                Text("예약 신청이 완료되었습니다!")
                    .font(.petIdTitle1)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack(spacing: 0) {
                    Text("예약 확정")
                        .foregroundColor(.blue)
                    Text("되면 알림으로 알려드릴게요.")
                        
                }
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
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HospitalSuccess()
}
