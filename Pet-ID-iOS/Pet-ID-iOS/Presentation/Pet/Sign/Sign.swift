import SwiftUI

struct Sign: View {
    @ObservedObject var viewModel: SignViewModel
    var coordinator: SignCoordinator

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
                    SignatureView(points: $viewModel.points)
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
}

struct SignatureView: View {
    @Binding var points: [CGPoint]
    
    var body: some View {
        VStack{
            Text("서명 또는 사인을 해주세요")
                .font(.headline)
                .foregroundColor(.petid_gray)
                .padding()
                .frame(height: 400)
            
            
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
}

#Preview {
    Sign(viewModel: SignViewModel(), coordinator: SignCoordinator(navigationController: UINavigationController()))
}
