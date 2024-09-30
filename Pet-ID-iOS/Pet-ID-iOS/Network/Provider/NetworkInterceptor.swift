//
//  NetworkInterceptor.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Alamofire
import Foundation

// 네트워크 요청을 가로채고 조작하는 클래스
public class NetworkInterceptor: RequestInterceptor, LoggAble {
    
    static let authRepository: AuthRepository = DefaultAuthRepository()
    
    // 요청을 조정하여 Authorization 헤더를 추가
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var newRequest = urlRequest
        
        
        // MARK: - adapt 내용 추가
        
        // 인증 API가 아닐 경우 Authorization 헤더 추가
        if !isAuthAPI(path: urlRequest.url?.pathComponents.joined()) {
            
            do {
                
                let authorization: Authorization = try Self.authRepository.fetchAuthTokensFromKeychainSync()
                newRequest.addValue(authorization.accessToken, forHTTPHeaderField: "Authentication")
                
            } catch {
                
            }
            
        }
        
        let httpRequest = newRequest
        
        // 요청 로그 출력
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
    
    // 요청이 실패했을 떄 재시도 로직
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) async {
        
        // 인증 API인 경우 재시도 하지 X
        if isAuthAPI(path: request.request?.url?.pathComponents.joined()) {
            completion(.doNotRetry)
        } else {
            // 401 Unauthorized 에러 발생 시 토큰 갱신 시도
            if request.response?.statusCode == 401 {
                
                do {
                    let authorization: Authorization = try Self.authRepository.fetchAuthTokensFromKeychainSync()
                    let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
                    _ = Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)
                    
                    completion(.retry) // 재시도
                    
                } catch {
                    completion(.doNotRetry) // 재시도 X
                }
                
            }
 
            completion(.doNotRetry) // 기본적으로 재시도하지 X
        }
    }
    
    
    // 주어진 경로가 인증 관련 API인지 확인
    func isAuthAPI(path: String?) -> Bool {
        
        if let path = path {
            
            return path.contains("authoauth2login") || path.contains("authoauth2join") || path.contains("authtokenrefresh")
            
        } else {
            
            return false
            
        }
    }
}
