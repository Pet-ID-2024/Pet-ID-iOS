import SwiftUI

struct BannerView: View {
    @StateObject private var viewModel = BannerViewModel()
    @State private var currentPage: Int = 0 // 현재 페이지 상태 추가
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect() // 5초마다 실행되는 타이머

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(viewModel.banners.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text(viewModel.banners[index].text ?? "No Text")
                        .frame(maxWidth: .infinity, alignment: .leading) // 너비를 고정하고 왼쪽 정렬
                        .multilineTextAlignment(.leading)
                    // 이미지는 일단 건드리지 않음
                    Text(viewModel.banners[index].imageUrl ?? "No Image URL")
//                    if let imageUrl = viewModel.banners[index].imageUrl, let url = URL(string: imageUrl) {
//                                            AsyncImage(url: url) { image in
//                                                image.resizable()
//                                            } placeholder: {
//                                                Color.gray // 로딩 중일 때는 회색 배경 표시
//                                            }
//                                            .frame(width: 300, height: 150)
//                                            .cornerRadius(10)
                }
                .frame(width: 300, height: 80) // 배너의 크기 설정
                .padding()
                .background(Color.red) // 배경색을 빨간색으로 설정
                .cornerRadius(30) // 모서리 둥글게
                .padding()
                .tag(index) // 태그 추가
            }
        }
//        .background(Color.blue)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(
            HStack {
                Spacer()
                Text("\(currentPage + 1) / \(viewModel.banners.count)")
                    .padding(8)
                    .background(Color.black.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.trailing, 16)
            }
            .padding(.bottom, 16), alignment: .bottom
        )
        .onAppear {
            viewModel.fetchBanners(type: "content")
        }
        .onReceive(timer) { _ in
            if viewModel.banners.count > 0 {
                currentPage = (currentPage + 1) % viewModel.banners.count // 마지막 페이지 다음엔 첫 페이지로
            }
        }
    }
}

// MARK: - Preview

#Preview {
    BannerView()
}
