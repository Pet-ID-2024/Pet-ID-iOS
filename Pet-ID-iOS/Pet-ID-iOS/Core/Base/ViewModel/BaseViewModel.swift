//
//  BaseViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/10/24.
//

import Foundation
import Combine

open class BaseViewModel {
    
    let logger: Logger = Logger()
    var cancelBag: Set<AnyCancellable> = .init()
    
    deinit {
        logger.debug("ViewModelDeinit!!!!!\n\(self)")
    }
}
