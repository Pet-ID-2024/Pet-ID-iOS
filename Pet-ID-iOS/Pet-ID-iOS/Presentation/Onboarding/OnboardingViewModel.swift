import SwiftUI
import Combine

enum OnboardingState {
    case next
}

final class OnboardingViewModel: BaseViewModel<OnboardingState> {
    // 현재 페이지를 나타내는 상태
    @Published var currentPage: Int = 0
     let totalPages: Int = 3 // 전체 페이지 수
    
    // 온보딩 완료 상태
    var onboardingCompleted: Bool {
        currentPage == totalPages - 1
    }
    
    // 버튼 클릭 시 동작
    func nextPage() {
        if onboardingCompleted {
            // 마지막 페이지에서 "next" 상태를 전파
            result.send(.next)
        } else {
            currentPage += 1
        }
    }
}
