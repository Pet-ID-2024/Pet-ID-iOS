//
//  Sign.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 10/1/24.
//

import SwiftUI

struct Sign: View {
    @ObservedObject var viewModel: SignViewModel
    var coordinator: SignCoordinator?
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("마지막")
                    .font(.body1_bold)
                    .foregroundColor(.petid_clearblue)
                
                Text("마지막으로 \n서명을 해주세요")
                    .font(.headline1)
                
                
                Text("반려동물등록 신청에 서명이 필요해요")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
            }
            .padding()
            
            HStack {
                Spacer()
                ZStack(alignment: .topTrailing) {
                    SignatureView(lines: $viewModel.lines)
                        .frame(width: 309, height: 359)
                        .background(Color.clear)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.vertical)
                    
                    Button(action: {
                        viewModel.clearButton()
                    }) {
                        DSImage.refreshicon.toImage()
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.petid_b4)
                    }
                    .padding(.trailing, 15) // 오른쪽 여백
                    .padding(.top, 30) // 상단 여백
                }
                Spacer()
            }
            
            Spacer()
            
            Button {
                viewModel.navigateToPCD()
            } label: {
                Text("다음")
                    .foregroundColor(.white)
                    .font(.body2_med)
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
    Sign(viewModel: SignViewModel(temporaryData: [:]))
}

struct SignatureView: View {
    @Binding var lines: [[CGPoint]]
    @State private var currentLine: [CGPoint] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("서명 또는 사인을 해주세요.")
                    .font(.body3_med)
                    .foregroundColor(.petid_gray)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                ForEach(lines.indices, id: \.self) { lineIndex in
                    Path { path in
                        let line = lines[lineIndex]
                        guard let firstPoint = line.first else { return }
                        path.move(to: firstPoint)
                        for point in line.dropFirst() {
                            path.addLine(to: point)
                        }
                    }
                    .stroke(Color.black, lineWidth: 2)
                }
                
                Path { path in
                    guard !currentLine.isEmpty else { return }
                    path.move(to: currentLine.first!)
                    for point in currentLine.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                .stroke(Color.black, lineWidth: 2)
            }
            .background(Color.white)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let touchPoint = value.location
                        if isPointInsideView(touchPoint, in: geometry.size) {
                            currentLine.append(touchPoint)
                        }
                    }
                    .onEnded { _ in
                        if !currentLine.isEmpty {
                            lines.append(currentLine)
                            currentLine.removeAll()
                        }
                    }
            )
        }
    }
    
    private func isPointInsideView(_ point: CGPoint, in size: CGSize) -> Bool {
        return point.x >= 0 && point.x <= size.width && point.y >= 0 && point.y <= size.height
    }
}
