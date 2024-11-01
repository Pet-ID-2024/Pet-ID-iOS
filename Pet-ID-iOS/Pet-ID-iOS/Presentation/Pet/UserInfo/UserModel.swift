//
//  UserModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 9/30/24.
//

import Foundation

struct UserModel {
    var name: String
    var phoneNumber: String
    var address: String
    var detailAddress: String
    
    var fullAddress: String {
        return address + " " + detailAddress
    }
}
