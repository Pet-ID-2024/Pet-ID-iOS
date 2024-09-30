//
//  ResultPublisher.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation
import Combine

// 결과 발행 퍼블리셔 클래스
class ResultPublisher<Result> {
    // 결과 값을 전달하기 위한 PassthroughSubject 생성
    private let _subject = PassthroughSubject<Result, Never>()
        
    // 메인 스레드에서 결과를 수신할 수 있는 퍼블리셔
    var subject: AnyPublisher<Result, Never> {
        return _subject
            .receive(on: DispatchQueue.main) // 메인 스레드에서 수신
            .eraseToAnyPublisher() // AnyPublisher로 변환
    }
    
    // 결과 값을 발송하는 메서드
    func send(_ value: Result) {
        _subject.send(value) // 주제에 값 발송
    }
}
