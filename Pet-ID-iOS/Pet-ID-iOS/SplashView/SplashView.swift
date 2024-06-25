import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("SplashImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
}

#Preview {
    SplashView()
}
