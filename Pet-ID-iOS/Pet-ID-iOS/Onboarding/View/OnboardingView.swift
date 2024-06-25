import SwiftUI

struct OnboardingPage: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var imageName: String
}

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $viewModel.currentPage) {
                    ForEach(viewModel.pages.indices, id: \.self) { index in
                        VStack {
                            Spacer()
                            Text(viewModel.pages[index].title)
                                .font(.largeTitle)
                                .bold()
                                .padding(.top, 100)
                            Text(viewModel.pages[index].description)
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding()
                            Image(viewModel.pages[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 500)
                                .padding(.bottom, 60)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                Button(action: {
                    viewModel.nextPage()
                }) {
                    Text(viewModel.isLastPage ? "시작하기" : "다음")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                NavigationLink(
                    destination: UseApp().navigationBarBackButtonHidden(),
                    isActive: $viewModel.isOnboardingCompleted,
                    label: {
                        EmptyView()
                    }
                )
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }

}
#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
