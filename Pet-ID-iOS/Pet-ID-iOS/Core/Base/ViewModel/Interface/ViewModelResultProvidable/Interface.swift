//
//  Interface.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/19/24.
//

import Foundation

protocol ResultProvidable {
    associatedtype Result
    @MainActor var result: ResultPublisher<Result> { get }
}

