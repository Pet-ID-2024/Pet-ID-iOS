import SwiftUI

struct SignatureView: View {
    @Binding var lines: [[CGPoint]]
    @State private var currentLine: [CGPoint] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("서명 또는 사인을 해주세요.")
                    .font(.petIdBody2)
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
