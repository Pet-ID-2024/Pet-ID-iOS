//import SwiftUI
//
//struct TestView: View {
//    @StateObject private var viewModel = TestViewModel()
//    
//    var body: some View {
//        VStack {
//            if case .loading = viewModel.state {
//                ProgressView("Loading...")
//            } else if case .failure(let message) = viewModel.state {
//                Text("Error: \(message)")
//            } else {
//                ScrollView {
//                    Text("Main Banners")
//                        .font(.headline)
//                    ForEach(viewModel.mainBanners) { banner in
//                        BannerRowView(banner: banner)
//                    }
//                    
//                    Text("Content Banners")
//                        .font(.headline)
//                    ForEach(viewModel.contentBanners) { banner in
//                        BannerRowView(banner: banner)
//                    }
//                }
//            }
//        }
//        .onAppear {
//            viewModel.loadMainBanners()
//            viewModel.loadContentBanners()
//        }
//    }
//}
//
//struct BannerRowView: View {
//    let banner: Banner
//    
//    var body: some View {
//        VStack {
//            if let imageUrl = banner.imageUrl, let url = URL(string: imageUrl) {
//                AsyncImage(url: url) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    case .failure:
//                        Color.gray
//                            .frame(height: 150)
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//                .frame(height: 150)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//            }
//            Text(banner.text)
//                .padding()
//        }
//    }
//}
//
//#Preview{
//    TestView()
//}
