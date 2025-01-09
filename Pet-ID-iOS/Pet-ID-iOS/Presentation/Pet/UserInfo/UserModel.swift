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
    var rra: String
    var rraDetails: String
    var isSameAddress: Bool = false
    
    mutating func syncAddresses() {
        if isSameAddress {
            rra = address
            rraDetails = detailAddress
        } else {
            rra = ""
            rraDetails = ""
        }
    }
    
    var fullAddress: String {
        return address + " " + detailAddress
    }
    
    var rraFullAddress: String {
        return rra + " " + rraDetails
    }
}
