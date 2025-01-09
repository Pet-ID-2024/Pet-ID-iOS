//import SwiftUI
//
//struct InputField: View {
//    var title: String
//    @Binding var text: String
//    var unit: String? = nil // 단위를 선택적으로 추가
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(title)
//                .font(.body4_med)
//                .foregroundColor(.petid_gray)
//
//            HStack {
//                TextField("", text: $text)
//                    .font(.body2_med)
//                    .foregroundColor(.petid_title)
//                    .keyboardType(unit == "kg" ? .decimalPad : .default) // "kg"일 경우 숫자 키보드 사용
//
//                if let unit = unit { // 단위가 있는 경우에만 추가
//                    Text(unit)
//                        .font(.body2_med)
//                        .foregroundColor(.black)
//                }
//
//                Button(action: {
//                    text = ""
//                }) {
//                    Image(systemName: "x.circle.fill")
//                        .foregroundColor(.petid_d9)
//                }
//            }
//
//            Divider()
//                .background(Color.petid_d9)
//        }
//    }
//}


import SwiftUI

struct InputField: View {
    var title: String
    @Binding var text: String
    var unit: String? = nil // 단위를 선택적으로 추가

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.body4_med)
                .foregroundColor(.petid_gray)

            HStack {
                // TextField와 단위를 합쳐서 보여줌
                HStack {
                    TextField("", text: $text)
                        .font(.body2_med)
                        .foregroundColor(.petid_title)
                        .keyboardType(.decimalPad) // 숫자 키보드 사용
                        .multilineTextAlignment(.trailing) // 입력 텍스트 오른쪽 정렬

                    if let unit = unit { // 단위가 있는 경우에만 추가
                        Text(unit)
                            .font(.body2_med)
                            .foregroundColor(.black)
                    }
                }

                // x.circle 버튼
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.petid_d9)
                }
            }

            Divider()
                .background(Color.petid_d9)
        }
    }
}
