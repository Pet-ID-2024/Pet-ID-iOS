import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel = SplashViewModel()
    @EnvironmentObject var appFlowState: AppFlowState
    
    var body: some View {
        
        Image("SplashImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    viewModel.autoLogin()
                })
            }
            .onReceive(viewModel.autoLoginPublisher) { result in
                if result {
                    appFlowState.currentFlow = .main
                } else {
                    appFlowState.currentFlow = .login
                }
            }
    }
}

#Preview {
    SplashView()
}
