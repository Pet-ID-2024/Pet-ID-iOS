import SwiftUI

struct ReservationListView: View {
    @ObservedObject var viewModel: ReservationListViewModel
    @State private var selectedReservation: ReservationList? // 선택된 예약
    @State private var showCancelDialog: Bool = false // 다이얼로그 표시 여부
    var body: some View {
        ZStack {
            VStack {
                headerView
                if viewModel.reservations.isEmpty {
                    emptyView
                } else {
                    reservationListView
                }
            }
            .padding()
            if showCancelDialog, let selectedReservation = selectedReservation {
                Dialog3(viewModel: Dialog3ViewModel(
                    title: "예약을 취소하시겠습니까?",
                    orderId: selectedReservation.id,
                    onSuccess: {
                        viewModel.removeReservation(selectedReservation)
                        showCancelDialog = false // 다이얼로그 닫기
                    }
                ))
                .transition(.opacity) // 애니메이션 효과
                .zIndex(1)
            }
        }
        .animation(.default, value: showCancelDialog)
    }
    
    private var headerView: some View {
        HStack {
            Button {
                viewModel.navigateBack()
            } label: {
                DSImage.chevronicon.toImage()
                    .font(.body2_reg)
            }
            
            Spacer()
            
            Text("예약 내역")
                .font(.body2_med)
                .foregroundColor(.petid_title)
            
            Spacer()
        }
        //        .padding(.top, 20)
    }
    
    
    private var emptyView: some View {
        VStack {
            Spacer()
            Text("예약 내역이 없습니다.")
                .font(.body1_reg)
                .foregroundColor(.petid_subtitle)
            Spacer()
        }
    }
    
    private var reservationListView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.reservations, id: \.id) {reservation in
                    ReservationRow(reservation: reservation){ selectedReservation in
                        self.selectedReservation = selectedReservation
                        self.showCancelDialog = true // 다이얼로그 표시
                    }
                }
            }
            .padding()
            .padding(.top, 20)
        }
    }
}

struct ReservationRow: View {
    let reservation: ReservationList
    let onCancelButtonTapped: (ReservationList) -> Void
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text(reservation.status.localized)
                        .font(.caption1_reg)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .foregroundColor(reservation.status.foregroundColor)
                        .background(reservation.status.backgroundColor)
                        .cornerRadius(10)
                    
                    Text(reservation.hospitalName)
                        .font(.body2_reg)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .foregroundColor(.petid_title)
                    
                    Text(reservation.formattedDate)
                        .font(.body25_reg)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .foregroundColor(.petid_subtitle)
                }
                
                Spacer()
                
                //                if reservation.status == .confirmed || reservation.status == .pending {
                Button {
                    onCancelButtonTapped(reservation)
                    
                } label: {
                    Text(buttonTitle(for: reservation.status))
                        .font(.caption1_reg)
                        .frame(width: 120, height: 37)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .foregroundColor(buttonForeground(for: reservation.status))
                        .background(buttonBackground(for: reservation.status))
                        .cornerRadius(10)
                }
                .padding(.top, 30)
                //                }
            }
            
            Divider()
                .background(Color.petid_lightgray)
            
            Spacer()
        }
        //        .padding()
    }
    
    // 버튼 텍스트 결정
    private func buttonTitle(for status: ReservationStatus) -> String {
        switch status {
        case .confirmed, .pending:
            return "예약 취소"
        case .completed, .cancelled:
            return "다시 예약"
        default:
            return "알 수 없음"
        }
    }
    
    // 버튼 글자 색상 결정
    private func buttonForeground(for status: ReservationStatus) -> Color {
        switch status {
        case .confirmed, .pending:
            return .petid_subtitle
        case .completed, .cancelled:
            return .white
        default:
            return .petid_subtitle
        }
    }
    
    // 버튼 배경 색상 결정
    private func buttonBackground(for status: ReservationStatus) -> Color {
        switch status {
        case .confirmed, .pending:
            return .petid_f2
        case .completed, .cancelled:
            return .petid_clearblue
        default:
            return .petid_f2
        }
    }
}

#Preview {
    ReservationListView(viewModel: ReservationListViewModel())
}
