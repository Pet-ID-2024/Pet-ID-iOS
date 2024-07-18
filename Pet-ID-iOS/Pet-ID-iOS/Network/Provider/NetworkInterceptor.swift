//
//  NetworkInterceptor.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Alamofire
import Foundation

public class NetworkInterceptor: RequestInterceptor, LoggAble {
    
    static let authRepository: AuthRepository = DefaultAuthRepository()
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var newRequest = urlRequest
        
        // MARK: - adapt 내용 추가
        
        if !isAuthAPI(path: urlRequest.url?.pathComponents.joined()) {
            
            do {
                
                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
                newRequest.addValue(authorization.accessToken, forHTTPHeaderField: "Authentication")
                
            } catch {
                
            }
            
        }
        
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
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) async {
        
        if isAuthAPI(path: request.request?.url?.pathComponents.joined()) {
            completion(.doNotRetry)
        } else {
            if request.response?.statusCode == 401 {
                
                do {
                    let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
                    let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
                    _ = Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)
                    
                    completion(.retry)
                    
                } catch {
                    completion(.doNotRetry)
                }
                
            }
 
            completion(.doNotRetry)
        }
    }
    
    
    func isAuthAPI(path: String?) -> Bool {
        
        if let path = path {
            
            return path.contains("authoauth2login") || path.contains("authoauth2join")
            
        } else {
            
            return false
            
        }
    }
}
