//
//  Interface.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation

// 결과 제공하는 프로토콜
protocol ResultProvidable {
    associatedtype Result // 관련된 결과 타입 정의
    
    // 결과를 제공하는 퍼블리셔를 메인 스레드에서 접근할 수 있도록 정의
    @MainActor var result: ResultPublisher<Result> { get }
}

