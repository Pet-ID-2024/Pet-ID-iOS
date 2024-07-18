//
//  BaseViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/10/24.
//

import Foundation
import Combine

open class BaseViewModel<ResultType>: ObservableObject, ResultProvidable {
    
    let result: ResultPublisher<ResultType> = .init()
    let logger: Logger = Logger()
    var cancelBag: Set<AnyCancellable> = .init()
    
    deinit {
        logger.debug("\(self) Deinit!!!!!")
    }
}
