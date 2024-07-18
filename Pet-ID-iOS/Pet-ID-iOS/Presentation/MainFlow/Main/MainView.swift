//
//  MainView.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Button(
            action: {
                let usecase = DefaultLogoutUseCase()
                usecase.execute()
            },
            label: {
                Text("키체인 인증정보 삭제")
            }
        )
    }
}

#Preview {
    MainView()
}
