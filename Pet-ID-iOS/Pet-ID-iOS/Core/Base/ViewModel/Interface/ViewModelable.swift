//
//  ViewModelable.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import Combine

protocol ViewModelable: ObservableObject {
    
    associatedtype Result
    
    var cancelBag: Set<AnyCancellable> { get set }
    var result: PassthroughSubject<Result, Never> { get }
}
