//
//  Hospital.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/4/24.
//

import Foundation

struct Hospital: Identifiable, Hashable {
    let id: Int
    let imageUrl: String?
    let address: String
    let name: String
    let hours: String?
    let tel: String
    let vet: String
}
