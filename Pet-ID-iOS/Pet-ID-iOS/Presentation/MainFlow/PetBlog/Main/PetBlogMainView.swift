import SwiftUI
import Kingfisher

struct PetBlogMainView: View {
    @ObservedObject var viewModel: PetBlogMainViewModel
    
    var body: some View {
        VStack {
            headerView
            tabBarView
            contentListView
        }
        .padding(.horizontal)
    }
    
    private var headerView: some View {
        HStack {
            Button {
                viewModel.navigateBack()
            } label: {
                DSImage.chevronicon.toImage()
                    .font(.body2_reg)
            }
            
            Spacer()
            
            Text("펫blog")
                .font(.body2_med)
                .foregroundColor(.petid_title)
            
            Spacer()
            
            Button {
                // 알림 기능 구현 예정
            } label: {
                DSImage.notificationicon.toImage()
                    .font(.title)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.petid_title)
            }
        }
        .padding(.top, 20)
    }
    
    private var tabBarView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 40) {
                ForEach(viewModel.tabs, id: \.key) { tab in
                    VStack {
                        Text(tab.value)
                            .font(.body3_med)
                            .foregroundColor(viewModel.selectedTabKey == tab.key ? .petid_title : .petid_subtitle)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 2)
                                .frame(maxWidth: .infinity)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(viewModel.selectedTabKey == tab.key ? .black : .clear)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            viewModel.onTabSelected(tab.key)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 10)
    }
    
    private var contentListView: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.blogs, id: \.contentId) { blog in
                    BlogPostCell(viewModel: viewModel, blog: blog)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 5)
    }
}

struct BlogPostCell: View {
    @ObservedObject var viewModel: PetBlogMainViewModel
    let blog: Blog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                viewModel.detail(for: blog)
            } label: {
                VStack(alignment: .leading, spacing: 10) {
                    if !blog.imageUrl.isEmpty, let url = URL(string: blog.imageUrl) {
                        KFImage(url)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                    }
                    
                    Text(blog.title)
                        .font(.body1_bold)
                        .foregroundColor(.petid_title)
                    
                    Text(blog.body)
                        .font(.body4_reg)
                        .foregroundColor(.petid_subtitle)
                        .lineLimit(2)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            HStack {
                HStack(spacing: 4) {
                    DSImage.hearticon.toImage()
                        .resizable()
                        .frame(width: 11, height: 9)
                        .foregroundColor(.petid_subtitle)
                    Text("\(blog.likesCount)")
                        .font(.caption1_reg)
                        .foregroundColor(.petid_subtitle)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .frame(width: 50, height: 25)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.petid_fa)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.petid_lightgray, lineWidth: 1)
                )
                
                Spacer()
                
                Button {
                    viewModel.prepareToShare(blog: blog)
                } label: {
                    DSImage.shareicon.toImage()
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.petid_subtitle)
                }
                .sheet(isPresented: $viewModel.isPresentingShareSheet) {
                    ActivityView(activityItems: viewModel.shareItems)
                }
            }
            Spacer()
            Divider()
                .background(Color.petid_lightgray)
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

// MARK: - 프리뷰
#Preview {
    PetBlogMainView(viewModel: PetBlogMainViewModel())
}
