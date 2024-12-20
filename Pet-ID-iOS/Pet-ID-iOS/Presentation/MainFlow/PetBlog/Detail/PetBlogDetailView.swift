import SwiftUI
import Kingfisher

struct PetBlogDetailView: View {
    @ObservedObject var viewModel: PetBlogDetailViewModel
    //    let blog: Blog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView
            ScrollView {
                titleSection
                imageSection
                contentSection
                likeAndShareSection
                    .padding(.bottom, 30)
                Rectangle()
                    .frame(height: 8)
                    .foregroundColor(.petid_f5)
                recommendBlog
                    .padding(.top, 30)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .sheet(isPresented: $viewModel.isPresentingShareSheet) {
            ActivityView(activityItems: viewModel.shareItems)
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                viewModel.navigateBack()
            }) {
                DSImage.chevronicon.toImage()
                    .font(.title)
                    .foregroundColor(.petid_title)
            }
            Spacer()
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.blog.title)
                .font(.headline2)
                .lineLimit(2)
                .foregroundColor(.petid_title)
            
            Text(viewModel.blog.createdAt)
                .font(.body4_reg)
                .foregroundColor(.petid_subtitle)
            
            Text(viewModel.blog.category)
                .font(.caption1_reg)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundColor(.petid_under_bar)
                .background(Color.petid_e9)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var imageSection: some View {
        VStack {
            if !viewModel.blog.imageUrl.isEmpty, let url = URL(string: viewModel.blog.imageUrl) {
                KFImage(url)
                    .resizable()
                    .frame(height: 200)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.blog.body)
                .font(.body25_reg)
                .foregroundColor(.petid_under_bar)
        }
    }
    
    private var likeAndShareSection: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("반려생활 공감을 남겨주세요")
                .font(.body2_bold)
                .foregroundColor(.petid_under_bar)
            
            Text("\(viewModel.blog.likesCount)명이 좋아했어요")
                .font(.body3_med)
                .foregroundColor(.petid_subtitle)
                .padding()
            
            HStack(spacing: 20) {
                Button(action: {
                    Task {
                        await viewModel.toggleLike()
                    }
                }) {
                    HStack {
                        DSImage.hearticon.toImage()
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 15, height: 13)
                            .foregroundColor(viewModel.isLikedByUser ? .petid_clearblue : .petid_subtitle)
                        
                        Text("좋아요")
                            .font(.body3_med)
                            .foregroundColor(viewModel.isLikedByUser ? .petid_clearblue : .petid_subtitle)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(viewModel.isLikedByUser ? Color.petid_clearblue : Color.petid_e3, lineWidth: 1)
                )
                .frame(width: 110)
                
                // 공유 버튼 추가
                Button {
                    viewModel.prepareToShare()
                } label: {
                    HStack {
                        DSImage.shareicon.toImage()
                            .resizable()
                            .frame(width: 16, height: 16)
                        
                        Text("공유하기")
                            .font(.body3_med)
                            .foregroundColor(.petid_subtitle)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.petid_e3, lineWidth: 1)
                )
                .frame(width: 110)
            }
        }
        .padding(.top, 10)
    }
    
    private var recommendBlog: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("알아두면 행복해지는 반려생활!\n이런 글은 어떤가요?")
                .font(.body1_bold)
                .multilineTextAlignment(.leading)
                .foregroundColor(.petid_title)
                .padding(.bottom, 8)
            
            ForEach(viewModel.recommendedBlogs, id: \.contentId) { blog in
                Button {
                    viewModel.result.send(.showDetail(blog: blog))
                } label: {
                    HStack(spacing: 12) {
                        if let url = URL(string: blog.imageUrl), !blog.imageUrl.isEmpty {
                            KFImage(url)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Text(blog.title)
                            .font(.body2_bold)
                            .foregroundColor(.petid_title)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(12)
                    .background(Color.petid_f2)
                    .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - 공유 시트 뷰
struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    PetBlogDetailView(viewModel: PetBlogDetailViewModel(blog: Blog(contentId: 1, title: "타이틀 글씨 테스트", body: "강아지 귀청소 요령 알려드려요!", category: "반려Tips", imageUrl: "", createdAt: "2021-12-12", updatedAt: "2022-12-13", likesCount: 2, authorId: 1, isLiked: true)))
}
