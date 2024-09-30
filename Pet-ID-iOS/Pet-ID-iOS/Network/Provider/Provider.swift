//
//  Provider.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

// API 요청을 처리하는 MoyaProvider를 확장한 클래스
public class Provider<T>: MoyaProvider<T> where T: TargetType {
    
    init() {
        // 기본 세션과 네트워크 인터셉터를 사용해 세션을 생성
        let session = Session(
            configuration: .default,
            interceptor: NetworkInterceptor()
        )
        
        // MoyaProvider를 초기화함. 로깅 플러그인도 포함
        super.init(
            session: session,
            plugins: [NetworkLoggerPlugin()]
        )
    }
    
    // 비동기 API 요청을 수행하고 응답을 디코드해 반환
    // target: 요청할 API 타겟
    // returns: 디코드된 응답 데이터
    // throws: 요청 중 발생한 오류
    func request<D: Decodable>(_ target: T) async throws -> D {
        return try await withCheckedThrowingContinuation { continuation in
            // 상위 클래스의 request 메서드를 호출
            super.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        // 성공적으로 응답을 필터링
                        let filterResonse = try response.filterSuccessfulStatusCodes()
                        
                        // 응답 데이터를 디코드
                        let decodedData = try filterResonse.map(D.self)
                        continuation.resume(returning: decodedData) // 디코드된 데이터를 반환
                    } catch let error  {
                        
                        if let moyaError = error as? MoyaError {
                            let networkError = NetworkError(error: moyaError) // MoyaError를 네트워크 오류로 변환해 던짐
                            continuation.resume(throwing: networkError)
                        } else {
                            Logger().error("ProviderError")
                            continuation.resume(throwing: NetworkError.unknown) // 알 수 없는 오류를 던짐
                        }
                    }
                case .failure(let error):
                    continuation.resume(throwing: NetworkError.moyaError(error)) // Moya오류를 던짐
                }
            }
            
        }
    }
}
