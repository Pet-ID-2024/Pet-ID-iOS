//import SwiftUI
//
//struct CustomDialog: View {
//    @Binding var isPresented: Bool
//    var title: String
//    var message: String
//    var confirmAction: () -> Void
//    var cancelAction: () -> Void
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text(title)
//                .font(.body1_med)
//                .foregroundColor(.petid_title)
//            Text(message)
//                .lineLimit(2)
//                .font(.body2_reg)
//                .foregroundColor(.petid_subtitle)
//                .multilineTextAlignment(.center)
//
//            HStack {
//                Button("취소") {
//                    cancelAction()
//                    isPresented = false // 취소 버튼 클릭 시 다이얼로그 닫기
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//
//                Button("확인") {
//                    confirmAction()
//                    isPresented = false // 확인 버튼 클릭 시 다이얼로그 닫기
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//            }
//        }
//        .padding()
//        .frame(width: 300, height: 185)
//        .background(Color.purple)
//        .cornerRadius(12)
//        .padding()
//        // 여기서 onTapGesture 제거
//    }
//}
//
//struct CustomContentView: View {
//    @State private var isDialogPresented: Bool = false
//    
//    var body: some View {
//        VStack {
//            Button("다이얼로그 열기") {
//                isDialogPresented = true
//            }
//        }
//        .overlay(
//            Group {
//                if isDialogPresented {
//                    CustomDialog(
//                        isPresented: $isDialogPresented,
//                        title: "알림 설정이 꺼져있습니다.",
//                        message: "알림 설정이 꺼져있는 경우 \n예약 관련 안내를 놓칠 수 있습니다.",
//                        confirmAction: {
//                            print("확인 버튼 클릭")
//                        },
//                        cancelAction: {
//                            print("취소 버튼 클릭")
//                        }
//                    )
//                }
//            }
//        )
//    }
//}
//
//#Preview {
//    CustomContentView()
//}

