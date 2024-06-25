import SwiftUI

struct InformationCheck: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                Text("신청 정보를 확인해주세요.")
                    .font(.title2)
                    .padding(.top)
                
                Text("언제든 수정할 수 있습니다")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 10) {
                    ForEach(0..<3) { _ in
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("상세 정보")
                        .font(.headline)
                    
                    DetailInfoView(label: "이름", value: "덕구")
                    DetailInfoView(label: "생일", value: "2022.03.02")
                    DetailInfoView(label: "성별", value: "남, 중성화x")
                    DetailInfoView(label: "품종", value: "믹스 푸들")
                    DetailInfoView(label: "특징", value: "갈색, 곱슬, 장모")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
                
                NavigationLink(destination: Sign().navigationBarBackButtonHidden()) {
                    Text("다음")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
            }
            .padding()
            
        }
    }
}

struct DetailInfoView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
        .padding(.vertical, 2)
    }
}

struct InformationCheck_Previews: PreviewProvider {
    static var previews: some View {
        InformationCheck()
    }
}
