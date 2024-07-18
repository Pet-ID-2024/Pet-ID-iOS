//
//  BaseViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/10/24.
//

import Foundation
import Combine

protocol ViewModelResultProvidable {
    associatedtype Result
    @MainActor var result: PassthroughSubject<Result, Never> { get }
}

open class BaseViewModel: ObservableObject {
    
    let logger: Logger = Logger()
    var cancelBag: Set<AnyCancellable> = .init()
    
    deinit {
        logger.debug("\(self) Deinit!!!!!")
    }
}
