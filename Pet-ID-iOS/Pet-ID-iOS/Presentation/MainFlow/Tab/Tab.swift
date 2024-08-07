//
//  Tab.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/25/24.
//

import SwiftUI

struct Tab: View {
    @StateObject var mainCoordinator = MainCoordinator(UINavigationController())

    var body: some View {
        TabView {
            MainView(viewModel: MainViewModel(coordinator: mainCoordinator), coordinator: mainCoordinator)
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            Text("First Tab")
                .tabItem {
                    Image(systemName: "plus")
                    Text("등록대행병원")
                }
            Text("First Tab")
                .tabItem {
                    Image(systemName: "doc")
                    Text("펫블로그")
                }
            Text("First Tab")
                .tabItem {
                    Image(systemName: "person")
                    Text("my")
                }
        }
    }
}

#Preview {
    Tab()
}
