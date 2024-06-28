import SwiftUI

struct Sign: View {
    @State private var points: [CGPoint] = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                
                Text("신청인의 서명 또는\n사인을 해주세요")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                SignatureView(points: $points)
                    .frame(width: 300, height: 200)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.vertical)
                
                Spacer()
                
//                NavigationLink(destination: RegistrationSuccess().navigationBarBackButtonHidden()) {
//                            Text("다음")
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                        }
            }
            .padding()
            
        }
    }
}

struct SignatureView: View {
    @Binding var points: [CGPoint]
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for i in 0..<points.count {
                    if i == 0 {
                        path.move(to: points[i])
                    } else {
                        path.addLine(to: points[i])
                    }
                }
            }
            .stroke(Color.black, lineWidth: 2)
            .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                            let touchPoint = value.location
                            guard touchPoint.x >= 0 && touchPoint.x <= geometry.size.width && touchPoint.y >= 0 && touchPoint.y <= geometry.size.height else { return }
                            points.append(touchPoint)
                        })
                        .onEnded({ _ in })
            )
        }
    }
}

#Preview {
    Sign()
}
