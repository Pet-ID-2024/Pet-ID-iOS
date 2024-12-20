import Foundation
import SwiftUI

import Foundation

// 프리사인드 URL 요청 함수
func fetchPresignedURL(for filePath: String, authToken: String, completion: @escaping (URL?) -> Void) {
    let urlString = "http://yourpet-id.com:8080/v1/banner/presigned-get-url?filePath=\(filePath)"
    guard let url = URL(string: urlString) else {
        print("유효하지 않은 URL 형식: \(urlString)")
        completion(nil)
        return
    }
    
    print("프리사인드 URL 요청 시작: \(urlString)")  // 요청 시작 로그
    
    // URLRequest 객체 생성
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization") // 토큰 추가
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("프리사인드 URL 요청 실패: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        // 응답 데이터를 디버깅 용도로 출력
        if let data = data, let responseString = String(data: data, encoding: .utf8) {
            print("서버 응답: \(responseString)")  // 서버 응답을 문자열로 출력
            
            // 응답 문자열을 URL로 변환 시도
            let trimmedResponse = responseString.trimmingCharacters(in: .whitespacesAndNewlines)
            if let presignedURL = URL(string: trimmedResponse) {
                print("프리사인드 URL 요청 성공: \(trimmedResponse)")
                completion(presignedURL)
            } else {
                print("프리사인드 URL 변환 실패: 잘못된 URL 형식")
                completion(nil)
            }
        } else {
            print("프리사인드 URL 파싱 실패: 데이터 없음 또는 문자열 변환 실패")
            completion(nil)
        }
    }
    task.resume()
}
struct BannerImageView: View {
    let filePath: String // S3 파일 경로
    @State private var presignedURL: URL?
    private let authToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMSIsInJvbGUiOiJST0xFX1VTRVIiLCJleHAiOjE3MzE0NjkyNTksInRva2VuVHlwZSI6IkFDQ0VTU19UT0tFTiJ9.gcg7h5pg8V0qX9cS_TykrDjH53k9WTsksCje0LQTBbE"

    var body: some View {
        VStack {
            if let url = presignedURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .onAppear { print("이미지 로드 중...") }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200)
                            .onAppear { print("이미지 로드 성공!") }
                    case .failure:
                        Text("이미지를 로드할 수 없습니다")
                            .foregroundColor(.gray)
                            .onAppear { print("이미지 로드 실패") }
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Text("프리사인드 URL을 가져오는 중...")
                    .onAppear {
                        fetchPresignedURL(for: filePath, authToken: authToken) { url in
                            DispatchQueue.main.async {
                                self.presignedURL = url
                            }
                        }
                    }
            }
        }
        .frame(width: 300, height: 200)
    }
}

#Preview {
    BannerImageView(filePath: "bannerImage/스크린샷 2024-08-03 191944.png")
}
