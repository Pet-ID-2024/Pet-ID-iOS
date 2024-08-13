//
//  ReservationMainView.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/13/24.
//

import SwiftUI

struct ReservationMainView: View {
    var body: some View {
        VStack(spacing: 0) {
            naviBar
        }
    }
    
    var naviBar: some View {
        HStack {
            Text("병원 예약")
        }
    }
}

#Preview {
    ReservationMainView()
}
