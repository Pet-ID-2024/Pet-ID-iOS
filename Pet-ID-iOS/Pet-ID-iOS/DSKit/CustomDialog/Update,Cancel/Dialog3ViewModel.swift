//
//  Dialog3ViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 12/11/24.
//

import Foundation
import Combine


final class Dialog3ViewModel: BaseViewModel<Void> {
    @Published var isPresented: Bool = true
    let title: String
    private let fetcher: ReservationListFetcher
    private let orderId: Int
    var onSuccess: (() -> Void)?

    init(fetcher: ReservationListFetcher = DefaultReservationListFetcher(), title: String, orderId: Int, onSuccess: (() -> Void)? = nil) {
        self.fetcher = fetcher
        self.orderId = orderId
        self.title = title
        self.onSuccess = onSuccess
    }
    
    func closeDialog() {
        isPresented = false
    }

    func cancelReservation() {
        Task {
            do {
                Logger().debug("📡📡📡📡📡📡📡📡📡📡📡📡 예약 취소 요청 시작: orderId = \(orderId)")
                
                let response = try await fetcher.cancelReservation(orderId: orderId)
                
                Logger().debug("✅✅✅✅✅✅✅✅✅✅✅✅✅ 예약 취소 성공: \(response.id)")
                
                DispatchQueue.main.async {
                    self.isPresented = false
                    self.onSuccess?() // 성공 시 콜백 호출
                }
            } catch {
                Logger().error("❌ 예약 취소 실패: \(error.localizedDescription)")
            }
        }
    }
}
