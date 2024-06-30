//
//  UserError.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation

enum UserError: Error {
    case anyError(Error)
    case userDataNotFound
}
