//
//  TermsAgreementViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation
import Combine

enum TermsAgreementViewModelResult {
    case back
    case signup
}

final class TermsAgreementViewModel: BaseViewModel, ViewModelResultProvidable {
    
    let result = PassthroughSubject<TermsAgreementViewModelResult, Never>()
    
    @Published var terms: [UserServiceTermsRequest]
    private let oauth: OAuth
    
    // MARK: - UseCasse
    private let joinUseCase: JoinUseCase
    private let loginUseCase: LoginUseCase
    
    init(
        oauth: OAuth,
        joinUseCase: JoinUseCase = DefaultJoinUseCase(),
        loginUseCase: LoginUseCase = DefaultLoginUseCase()
    ) {
        self.oauth = oauth
        terms = UserServiceTerms.allCases
            .map {
                return UserServiceTermsRequest(
                    term: $0
                )
            }
        
        self.joinUseCase = joinUseCase
        self.loginUseCase = loginUseCase
    }
    
    func handleAllAgreeTap(_ value: Bool) {
        if value == true {
            terms = terms.map { term in
                var newterm = term
                newterm.isAgreed = false
                return newterm
            }
        } else {
            terms = terms.map { term in
                var newterm = term
                newterm.isAgreed = true
                return newterm
            }
        }
    }
}

extension TermsAgreementViewModel {
    func handleBackBtnTap() {
        result.send(.back)
    }
    
    func handleJoinBtnTap() {
        Task {
            do {
                try await joinUseCase.execute(
                    oauth: oauth,
                    fcmToken: UserDefaultManager.shared.fcmToken,
                    agreedAd: terms.first(where: {
                        $0.term == .marketingInfoReception
                    })?.isAgreed ?? false
                )
                
                let result = try await loginUseCase.execute(
                    oauth: oauth,
                    fcmToken: UserDefaultManager.shared.fcmToken
                )
                
                if result {
                    self.result.send(.signup)
                    logger.debug("LoginSuccessed")
                } else {
                    logger.debug("LoginFailed")
                }
            } catch {
                logger.error(error)
            }
        }
    }
}
