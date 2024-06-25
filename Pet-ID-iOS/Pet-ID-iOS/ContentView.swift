//
//  ContentView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showMainView = false
    
    var body: some View {
        ZStack {
            if showMainView {
//                OnboardingView(viewModel: OnboardingViewModel())
                PetCardStart()
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
