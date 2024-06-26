import Combine
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var isOnboardingCompleted = false
    
    let pages = [
        OnboardingPage(title: "바쁜 반려인들을 위해서", description: "비대면 반려동물 신청", imageName: "OnboardingView1"),
        OnboardingPage(title: "내 근처 내장칩 병원 연결", description: "병원 추천과 방문 예약", imageName: "OnboardingView2"),
        OnboardingPage(title: "반려동물 관리 시작!", description: "모바일 반려동물증 발급", imageName: "OnboardingView3")
    ]
    
    var isLastPage: Bool {
        currentPage == pages.count - 1
    }
    
    func nextPage() {
        if currentPage < pages.count - 1 {
            currentPage += 1
        } else {
            isOnboardingCompleted = true
        }
    }
}
