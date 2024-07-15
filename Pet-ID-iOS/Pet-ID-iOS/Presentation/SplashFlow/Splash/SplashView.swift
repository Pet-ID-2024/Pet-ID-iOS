import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel = SplashViewModel()
    
    var body: some View {
        DSImage.splashimage.uiImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    viewModel.run()
                })
            }
    }
}

#Preview {
    SplashView()
}
