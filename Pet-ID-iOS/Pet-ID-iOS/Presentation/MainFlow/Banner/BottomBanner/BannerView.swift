import SwiftUI

struct BannerView: View {
    @StateObject private var viewModel = BannerViewModel()
    @State private var imageUrls: [String: String] = [:] 
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    ForEach(viewModel.banners) { banner in
                        VStack(alignment: .leading) {
                            if let imageUrl = banner.imageUrl {
                                if let cachedUrl = imageUrls[imageUrl] {
                                    AsyncImage(url: URL(string: cachedUrl)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                } else {
//                                    viewModel.fetchPresignedUrl(for: imageUrl) { url in
//                                        if let url = url {
//                                            imageUrls[imageUrl] = url
//                                        }
//                                    }
                                    ProgressView()
                                }
                            }
                            Text(banner.text ?? "")
                                .font(.body)
                                .padding(.vertical)
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchBanners(type: "content") // Fetch banners of type 'content'
        }
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
