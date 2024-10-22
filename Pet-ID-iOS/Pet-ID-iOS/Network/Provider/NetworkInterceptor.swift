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
    static let logoutUseCase: LogoutUseCase = DefaultLogoutUseCase()

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {

        var newRequest = urlRequest

        if !isAuthAPI(path: urlRequest.url?.pathComponents.joined()) {
            do {
                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
                newRequest.addValue(authorization.accessToken, forHTTPHeaderField: "Authorization")
            } catch {
                logger.error("Authorization 추가 실패: \(error)")
            }
        }

        logger.debug("Authorization 헤더: \(newRequest.allHTTPHeaderFields?["Authorization"] ?? "없음")")

        completion(.success(newRequest))
    }

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) async {
        if request.response?.statusCode == 401 {
            do {
                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
                let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
                _ = Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)
                
                print("🟢 토큰 갱신 성공: \(refreshedAuthorization.accessToken)")
                
                completion(.retry) // 재시도
            } catch {
                Logger().error("❌ 토큰 재발급 실패: \(error)")
                Self.logoutUseCase.execute() // 실패 시 로그아웃 처리
                completion(.doNotRetry)
            }
        } else {
            completion(.doNotRetry)
        }
    }

    private func handleTokenRefresh(_ request: Request, completion: @escaping (RetryResult) -> Void) async {
        if request.retryCount < 3 {
            do {
                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
                let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
                _ = Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)

                logger.debug("토큰 갱신 성공")
                completion(.retry)
            } catch {
                logger.error("토큰 재발급 실패: \(error.localizedDescription)")
                Self.logoutUseCase.execute()
                completion(.doNotRetry)
            }
        } else {
            logger.error("재시도 횟수 초과")
            Self.logoutUseCase.execute()
            completion(.doNotRetry)
        }
    }

    func isAuthAPI(path: String?) -> Bool {
        guard let path = path else { return false }
        return path.contains("authoauth2login") || path.contains("authoauth2join") || path.contains("authtokenrefresh")
    }

    private func logRequest(_ request: URLRequest) {
        let url = request.url?.absoluteString ?? "unknown"
        let method = request.httpMethod ?? "unknown"
        let headers = request.allHTTPHeaderFields?.map { "\($0): \($1)" }.joined(separator: "\n") ?? "No headers"
        let body = request.httpBody.flatMap { String(data: $0, encoding: .utf8) } ?? "No body"

        print(
            """
            🛰 NETWORK Request LOG
            URL: \(url)
            Method: \(method)
            Headers:
            \(headers)
            Body:
            \(body)
            [HTTP Request Ended]
            """
        )
    }
}

////
////  NetworkInterceptor.swift
////  Pet-ID-iOS
////
////  Created by 강현준 on 7/12/24.
////
//
//import Alamofire
//import Foundation
//
//public class NetworkInterceptor: RequestInterceptor, LoggAble {
//
//    static let authRepository: AuthRepository = DefaultAuthRepository()
//    static let logoutUseCase: LogoutUseCase = DefaultLogoutUseCase()
//
//    // Request에 Authorization 헤더 추가 (Access Token)
//    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        var newRequest = urlRequest
//
//        // 인증 API가 아닌 경우 Authorization 헤더 추가
//        if !isAuthAPI(path: urlRequest.url?.pathComponents.joined()) {
//            do {
//                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
//                newRequest.addValue(authorization.accessToken, forHTTPHeaderField: "Authorization")
//                print("Authorization 헤더 추가됨: \(authorization.accessToken)")
//            } catch {
//                print("Authorization 헤더 추가 실패: \(error.localizedDescription)")
//            }
//        }
//
//        logRequest(newRequest)
//        completion(.success(newRequest))
//    }
//
//    // 401 에러 발생 시 토큰 리프레시 로직 추가
//    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) async {
//        print("Retry 메서드 호출됨")  // 진입 여부 확인
//
//        // 인증 관련 API일 경우 재시도하지 않음
//        if isAuthAPI(path: request.request?.url?.pathComponents.joined()) {
//            print("인증 API 호출, 재시도하지 않음")
//            completion(.doNotRetry)
//        } else {
//            if let response = request.response, response.statusCode == 401 {
//                print("401 에러 발생, 토큰 갱신 시도")
//                do {
//                    // 기존 토큰 가져오기
//                    let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
//                    print("현재 refreshToken:", authorization.refreshToken)
//                    
//                    // 리프레시 토큰으로 새로운 토큰 요청
//                    let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
//                    print("새로운 accessToken:", refreshedAuthorization.accessToken)
//                    
//                    // 새로운 토큰을 키체인에 저장
//                    let isUpdated = Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)
//                    
//                    if isUpdated {
//                        print("토큰 갱신 완료, 요청 재시도")
//                        completion(.retry)
//                    } else {
//                        print("토큰 갱신 후 키체인 업데이트 실패")
//                        completion(.doNotRetry)
//                    }
//                } catch {
//                    print("토큰 갱신 실패:", error)
//                    // 토큰 갱신 실패 시 로그아웃 처리
//                    Self.logoutUseCase.execute()
//                    completion(.doNotRetry)
//                }
//            } else {
//                print("401 오류 외 다른 오류로 인해 재시도하지 않음")
//                completion(.doNotRetry)
//            }
//        }
//    }
//
//    // API 경로가 인증 관련 경로인지 확인
//    func isAuthAPI(path: String?) -> Bool {
//        guard let path = path else { return false }
//        return path.contains("auth/oauth2/login") || path.contains("auth/oauth2/join") || path.contains("auth/token/refresh")
//    }
//
//    // 로그 출력 함수 (요청 정보 출력)
//    private func logRequest(_ request: URLRequest) {
//        let url = request.url?.absoluteString ?? "unknown nil"
//        let method = request.httpMethod ?? "unknown method"
//        var httpHeader: String = ""
//
//        request.allHTTPHeaderFields?.forEach {
//            httpHeader.append("     \($0): \($1)\n")
//        }
//
//        var requestBody: String = ""
//        if let httpBody = request.httpBody, let bodyString = String(bytes: httpBody, encoding: .utf8) {
//            requestBody = "\n\(bodyString)"
//        }
//
//        print(
//            """
//            🛰 NETWORK Request LOG
//            URL: \(url)
//            Method: \(method)
//            Header:
//            \(httpHeader)
//            RequestBody:
//            \(requestBody)
//            [HTTP Request Ended]
//            """
//        )
//    }
//}
