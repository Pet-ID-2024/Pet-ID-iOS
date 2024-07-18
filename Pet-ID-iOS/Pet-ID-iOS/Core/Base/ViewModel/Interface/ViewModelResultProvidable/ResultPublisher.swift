//
//  ResultPublisher.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation
import Combine

class ResultPublisher<Result> {
    private let _subject = PassthroughSubject<Result, Never>()
        
    
    var subject: AnyPublisher<Result, Never> {
        return _subject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func send(_ value: Result) {
        _subject.send(value)
    }
}
