import SwiftUI
import Kingfisher

struct BannerView1: View {
    let imageUrlString: String
    let bannerText: String
    
    var body: some View {
        VStack {
            if let url = URL(string: imageUrlString) {
                KFImage(url)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
            } else {
                Text("Invalid URL")
                    .foregroundColor(.red)
            }
            
            Text(bannerText)
                .font(.headline)
                .padding(.top, 5)
        }
        .padding()
    }
}

#Preview {
    let presignedUrl = "https://petid-bucket.s3.ap-northeast-2.amazonaws.com/bannerImage/asdf.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20241113T051243Z&X-Amz-SignedHeaders=host&X-Amz-Expires=60&X-Amz-Credential=AKIA5FTZCM4CBFIMMCFV%2F20241113%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=8fac39c8d08c8df9d977234cec0f28477831aa1960420f68c55a4e081ffa0b65"
    let sampleText = "Sample Banner Text"
    
    return BannerView1(imageUrlString: presignedUrl, bannerText: sampleText)
}
