//
//  NetworkInterceptor.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

//import Alamofire
//import Foundation
//
//public class NetworkInterceptor: RequestInterceptor, LoggAble {
//
//    static let authRepository: AuthRepository = DefaultAuthRepository()
//    static let logoutUseCase: LogoutUseCase = DefaultLogoutUseCase()
//
//    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//
//        var newRequest = urlRequest
//
//        if !isAuthAPI(path: urlRequest.url?.pathComponents.joined()) {
//            do {
//                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
//                newRequest.addValue(authorization.accessToken, forHTTPHeaderField: "Authorization")
//            } catch {
//                logger.error("Authorization 추가 실패: \(error)")
//            }
//        }
//
//        logger.debug("Authorization 헤더: \(newRequest.allHTTPHeaderFields?["Authorization"] ?? "없음")")
//
//        completion(.success(newRequest))
//    }
//
//    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) async {
//        if request.response?.statusCode == 401 {
//            do {
//                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
//                let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
//                _ = Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)
//
//                print("🟢 토큰 갱신 성공: \(refreshedAuthorization.accessToken)")
//
//                completion(.retry) // 재시도
//            } catch {
//                Logger().error("❌ 토큰 재발급 실패: \(error)")
//                Self.logoutUseCase.execute() // 실패 시 로그아웃 처리
//                completion(.doNotRetry)
//            }
//        } else {
//            completion(.doNotRetry)
//        }
//    }
//
//    private func handleTokenRefresh(_ request: Request, completion: @escaping (RetryResult) -> Void) async {
//        if request.retryCount < 3 {
//            do {
//                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
//                let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
//                _ = Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)
//
//                logger.debug("토큰 갱신 성공")
//                completion(.retry)
//            } catch {
//                logger.error("토큰 재발급 실패: \(error.localizedDescription)")
//                Self.logoutUseCase.execute()
//                completion(.doNotRetry)
//            }
//        } else {
//            logger.error("재시도 횟수 초과")
//            Self.logoutUseCase.execute()
//            completion(.doNotRetry)
//        }
//    }
//
//    func isAuthAPI(path: String?) -> Bool {
//        guard let path = path else { return false }
//        return path.contains("authoauth2login") || path.contains("authoauth2join") || path.contains("authtokenrefresh")
//    }
//
//    private func logRequest(_ request: URLRequest) {
//        let url = request.url?.absoluteString ?? "unknown"
//        let method = request.httpMethod ?? "unknown"
//        let headers = request.allHTTPHeaderFields?.map { "\($0): \($1)" }.joined(separator: "\n") ?? "No headers"
//        let body = request.httpBody.flatMap { String(data: $0, encoding: .utf8) } ?? "No body"
//
//        print(
//            """
//            🛰 NETWORK Request LOG
//            URL: \(url)
//            Method: \(method)
//            Headers:
//            \(headers)
//            Body:
//            \(body)
//            [HTTP Request Ended]
//            """
//        )
//    }
//}



import Alamofire
import Foundation

public class NetworkInterceptor: RequestInterceptor, LoggAble {

    static let authRepository: AuthRepository = DefaultAuthRepository()
    static let logoutUseCase: LogoutUseCase = DefaultLogoutUseCase()
    private let authPaths: Set<String> = ["auth/oauth2/login", "auth/oauth2/join", "auth/token/refresh"]

    // MARK: - URLRequest Adaptation
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var newRequest = urlRequest
        
        // 로그: 토큰 추가 시작
        logger.debug("🔑 Authorization 헤더 추가 시작 - URL: \(urlRequest.url?.absoluteString ?? "nil")")

        // 인증이 필요한 API 요청인지 확인
        if !isAuthAPI(path: urlRequest.url?.path) {
            do {
                let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
                newRequest.addValue(authorization.accessToken, forHTTPHeaderField: "Authorization")
                logger.debug("🔑 Authorization 헤더 설정 - accessToken: \(authorization.accessToken)")
            } catch {
                logger.error("❌ Authorization 추가 실패: \(error.localizedDescription)")
            }
        } else {
            logger.debug("🔓 인증이 필요 없는 API 호출입니다.")
        }

        logger.debug("🔑 최종 Authorization 헤더: \(newRequest.allHTTPHeaderFields?["Authorization"] ?? "없음")")
        completion(.success(newRequest))
    }

    // MARK: - Retry Logic
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        logger.debug("🔄 Retry 메서드 실행 - 상태 코드: \(request.response?.statusCode ?? 0)")
        if request.response?.statusCode == 401 {
            logger.debug("🔄 401 Unauthorized - 토큰 갱신 시도 중")
            Task {
                await handleTokenRefresh(request, completion: completion)
            }
        } else {
            completion(.doNotRetry)
        }
    }

    // MARK: - Token Refresh Handling
    private func handleTokenRefresh(_ request: Request, completion: @escaping (RetryResult) -> Void) async {
        if request.retryCount < 3 {
            do {
                let refreshedAuthorization = try await refreshAuthorization()
                logger.debug("🟢 토큰 갱신 성공 - new accessToken: \(refreshedAuthorization.accessToken)")
                completion(.retry)
            } catch {
                logger.error("❌ 토큰 재발급 실패: \(error.localizedDescription) | 경로: \(request.request?.url?.absoluteString ?? "unknown")")
//                performLogout()
                completion(.doNotRetry)
            }
        } else {
            logger.error("⚠️ 재시도 횟수 초과")
//            performLogout()
            completion(.doNotRetry)
        }
    }

    // MARK: - Authorization Refresh Logic
    private func refreshAuthorization() async throws -> Authorization {
        logger.debug("🔄 Authorization 갱신 시작")
        let authorization: Authorization = try Self.authRepository.getAuthorizationFromKeychain()
        logger.debug("🔄 현재 refreshToken: \(authorization.refreshToken)")
        
        let refreshedAuthorization = try await Self.authRepository.refresh(refreshToken: authorization.refreshToken)
        try Self.authRepository.updateAuthorizationToKeychain(auth: refreshedAuthorization)
        
        logger.debug("✅ Authorization 갱신 완료 - new accessToken: \(refreshedAuthorization.accessToken), new refreshToken: \(refreshedAuthorization.refreshToken)")
        return refreshedAuthorization
    }

    // MARK: - Helper Functions
//    private func performLogout() {
//        Self.logoutUseCase.execute()
//        logger.debug("✅ 로그아웃 성공")
//    }

    func isAuthAPI(path: String?) -> Bool {
        guard let path = path else { return false }
        return authPaths.contains(where: { path.contains($0) })
    }

    // MARK: - Request Logging
    private func logRequest(_ request: URLRequest) {
        let url = request.url?.absoluteString ?? "unknown"
        let method = request.httpMethod ?? "unknown"
        let headers = request.allHTTPHeaderFields?.map { "\($0): \($1)" }.joined(separator: "\n") ?? "No headers"
        let body = request.httpBody.flatMap { String(data: $0, encoding: .utf8) } ?? "No body"

        logger.debug(
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
