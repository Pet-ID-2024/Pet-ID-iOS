import SwiftUI
import Kingfisher

struct BannerView: View {
    @StateObject private var viewModel = BannerViewModel()
    @State private var currentPage: Int = 0 // 현재 페이지 인덱스
    private let type: BannerType
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect() // 5초마다 자동 페이지 이동
    
    init(type: BannerType) {
        self.type = type
    }
    
    var body: some View {
        ZStack {
            if viewModel.banners.isEmpty {
                // 데이터가 없을 때 표시될 화면
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
            } else {
                // 배너 이미지 표시
                TabView(selection: $currentPage) {
                    ForEach(viewModel.banners.indices, id: \.self) { index in
                        let banner = viewModel.banners[index]
                        ZStack {
                            if let imageUrl = banner.imageUrl, let url = URL(string: imageUrl) {
                                KFImage(url)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    .onAppear {
//                                        print("🟢 Kingfisher 이미지 로딩 시작: \(url.absoluteString)")
                                    }
                            } else {
                                // 이미지 URL이 없을 경우 기본 Placeholder
                                Color.gray
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .onReceive(timer) { _ in
                    // 자동 페이지 전환
                    if !viewModel.banners.isEmpty {
                        currentPage = (currentPage + 1) % viewModel.banners.count
                    }
                }
                
                // 페이지 인디케이터
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("\(currentPage + 1) / \(viewModel.banners.count)")
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.trailing, 16)
                    }
                    .padding(.bottom, 16)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadBanners(type: type)
            }
        }
    }
}

// MARK: - Preview
struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(type: .main)
    }
}
