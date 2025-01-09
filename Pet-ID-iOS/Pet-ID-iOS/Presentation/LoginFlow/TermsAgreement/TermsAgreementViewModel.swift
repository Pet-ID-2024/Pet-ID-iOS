////
////  TermsAgreementViewModel.swift
////  Pet-ID-iOS
////
////  Created by 강현준 on 7/18/24.
////
//
//import Foundation
//import Combine
//
//enum TermsAgreementViewModelResult {
//    case back
//    case signup
//}
//
//final class TermsAgreementViewModel: BaseViewModel<TermsAgreementViewModelResult> {
//    
//    @Published var terms: [UserServiceTermsRequest]
//    private let oauth: OAuth
//    
//    // MARK: - UseCasse
//    private let joinUseCase: JoinUseCase
//    private let loginUseCase: LoginUseCase
//    
//    init(
//        oauth: OAuth,
//        joinUseCase: JoinUseCase = DefaultJoinUseCase(),
//        loginUseCase: LoginUseCase = DefaultLoginUseCase()
//    ) {
//        self.oauth = oauth
//        terms = UserServiceTerms.allCases
//            .map {
//                return UserServiceTermsRequest(
//                    term: $0
//                )
//            }
//        
//        self.joinUseCase = joinUseCase
//        self.loginUseCase = loginUseCase
//    }
//    
//    func handleAllAgreeTap(_ value: Bool) {
//        if value == true {
//            terms = terms.map { term in
//                var newterm = term
//                newterm.isAgreed = false
//                return newterm
//            }
//        } else {
//            terms = terms.map { term in
//                var newterm = term
//                newterm.isAgreed = true
//                return newterm
//            }
//        }
//    }
//}
//
//extension TermsAgreementViewModel {
//    func handleBackBtnTap() {
//        result.send(.back)
//    }
//    
//    func handleJoinBtnTap() {
//        Task {
//            do {
//                try await joinUseCase.execute(
//                    oauth: oauth,
//                    fcmToken: UserDefaultManager.shared.fcmToken,
//                    agreedAd: terms.first(where: {
//                        $0.term == .marketingInfoReception
//                    })?.isAgreed ?? false
//                )
//                
//                let result = try await loginUseCase.execute(
//                    oauth: oauth,
//                    fcmToken: UserDefaultManager.shared.fcmToken
//                )
//                
//                if result {
//                    self.result.send(.signup)
//                    logger.debug("LoginSuccessed")
//                } else {
//                    logger.debug("LoginFailed")
//                }
//            } catch {
//                logger.error(error)
//            }
//        }
//    }
//}


import Foundation
import Combine

enum TermsAgreementViewModelResult {
    case login // 약관 동의 완료 후 메인 화면 이동
}

final class TermsAgreementViewModel: BaseViewModel<TermsAgreementViewModelResult> {
    
    @Published var terms: [UserServiceTermsRequest]
    private let oauth: OAuth
    
    // MARK: - UseCase
    private let loginUseCase: LoginUseCase
    
    init(
        oauth: OAuth,
        loginUseCase: LoginUseCase = DefaultLoginUseCase()
    ) {
        self.oauth = oauth
        self.terms = UserServiceTerms.allCases.map {
            UserServiceTermsRequest(term: $0)
        }
        self.loginUseCase = loginUseCase
        super.init()
    }
    
    /// 약관 전체 동의/해제
    func handleAllAgreeTap(_ value: Bool) {
        terms = terms.map { term in
            var newTerm = term
            newTerm.isAgreed = value
            return newTerm
        }
    }
    
    /// 필수 약관이 모두 동의되었는지 확인
    var areRequiredTermsAgreed: Bool {
        return terms.filter { $0.term.agreementType == .required }
            .allSatisfy { $0.isAgreed }
    }
    
    /// 약관 동의 후 메인 화면 이동
    func handleAgreeAndLoginTap() {
        guard areRequiredTermsAgreed else {
            logger.error("Required terms are not agreed")
            return
        }
        
        Task {
            do {
                // OAuth를 사용해 로그인 진행
                let result = try await loginUseCase.execute(
                    oauth: oauth,
                    fcmToken: UserDefaultManager.shared.fcmToken
                )
                
                if result {
                    // 로그인 성공 시 메인 화면으로 이동
                    self.result.send(.login)
                } else {
                    logger.error("Login failed")
                }
            } catch {
                logger.error("Login error: \(error)")
            }
        }
    }
}
