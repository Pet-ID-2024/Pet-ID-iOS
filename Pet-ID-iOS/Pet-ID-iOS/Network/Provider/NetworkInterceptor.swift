//
//  NetworkInterceptor.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Alamofire
import Foundation

public class NetworkInterceptor: RequestInterceptor {
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var urlRequest = urlRequest
        
        let path = urlRequest.url?.pathComponents.joined(separator: "/") ?? ""
        
        print("🛰 NETWORK Path: \(path)")
        
        if path.contains("/auth/oath2/login") {
            completion(.success(urlRequest))
        }
        
        completion(.success(urlRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
    }
}
