//
//  BaseViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/10/24.
//

import Foundation
import Combine

open class BaseViewModel<ResultType>: NSObject, ObservableObject, ResultProvidable {
    
    // 결과를 발행하는 ResultPublisher 생성
    let result: ResultPublisher<ResultType> = .init()
    let logger: Logger = Logger() // 로거 인스턴스
    var cancelBag: Set<AnyCancellable> = .init() // Combine의 구독 취소를 위한 컨테이너
    
    // 소멸자에서 디버그 로그 출력
    deinit {
        logger.debug("\(self) Deinit!!!!!")
    }
}
