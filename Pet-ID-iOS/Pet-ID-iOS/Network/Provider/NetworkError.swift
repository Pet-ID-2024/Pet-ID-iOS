//
//  NetworkError.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation
import Foundation
import Moya

enum NetworkError: Error {
    case moyaError(MoyaError)
    case invalidResponse(ErrorModel)
    case unknown
    case decodingError
    
    init(error: MoyaError) {
        switch error {
        case .statusCode(let response):
            do {
                let decoder = JSONDecoder()
                let errorModel = try decoder.decode(ErrorModel.self, from: response.data)
                self = .invalidResponse(errorModel)
            } catch {
                print("NetworkError Catch \(response)")
                self = .decodingError
            }
        default: self = .unknown
        }
    }
}
