//
//  BaseViewModel.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

open class BaseViewModel: ObservableObject {
    
    public var cancellBag = Set<AnyCancellable>()
}
