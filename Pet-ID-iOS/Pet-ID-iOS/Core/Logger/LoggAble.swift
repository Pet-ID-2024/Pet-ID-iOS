//
//  LoggAble.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation

protocol LoggAble {
    var logger: Logger { get }
}

extension LoggAble {
    var logger: Logger {
        return Logger()
    }
}
