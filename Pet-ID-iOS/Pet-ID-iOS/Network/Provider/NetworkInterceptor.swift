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
    
        var newRequest = urlRequest

        // MARK: - adapt 내용 추가
        
        let httpRequest = newRequest
        
        let url = newRequest.url?.absoluteString ?? "unknown nil"
        let method = newRequest.httpMethod ?? "unknown method"
        var httpHeader: String = ""
        
        newRequest.allHTTPHeaderFields?.forEach {
            httpHeader.append("     \($0): \($1)\n")
        }
        
        var requestBody: String = ""
        
        if let httpBody = newRequest.httpBody, let bodyString = String(
            bytes: httpBody,
            encoding: .utf8
        ) {
            requestBody = "\n\(bodyString)"
        }
        
        print(
            "\n" +
            "🛰 V2 NETWORK Reqeust LOG \n"
            + "URL: \(url)\n"
            + "Method: \(method)\n"
            + "Header: \n\(httpHeader)\n"
            + "RequestBody: \n\(requestBody)\n"
            + "[HTTP Request Ended]"
        )
        
        completion(.success(newRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
