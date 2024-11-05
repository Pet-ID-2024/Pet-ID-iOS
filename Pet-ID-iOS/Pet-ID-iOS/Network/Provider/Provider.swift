////
////  Provider.swift
////  Pet-ID-iOS
////
////  Created by 강현준 on 7/12/24.
////
//
//import Foundation
//import Moya
//
//public class Provider<T>: MoyaProvider<T> where T: TargetType {
//    
//    init() {
//        let session = Session(
//            configuration: .default,
//            interceptor: NetworkInterceptor()
//        )
//        
//        super.init(
//            session: session,
//            plugins: [NetworkLoggerPlugin()]
//        )
//    }
//    
//    func request<D: Decodable>(_ target: T) async throws -> D {
//        return try await withCheckedThrowingContinuation { continuation in
//            super.request(target) { result in
//                switch result {
//                case .success(let response):
//                    do {
//                        let filterResonse = try response.filterSuccessfulStatusCodes()
//                        let decodedData = try filterResonse.map(D.self)
//                        continuation.resume(returning: decodedData)
//                    } catch let error  {
//                        
//                        if let moyaError = error as? MoyaError {
//                            let networkError = NetworkError(error: moyaError)
//                            continuation.resume(throwing: networkError)
//                        } else {
//                            Logger().error("ProviderError")
//                            continuation.resume(throwing: NetworkError.unknown)
//                        }
//                    }
//                case .failure(let error):
//                    continuation.resume(throwing: NetworkError.moyaError(error))
//                }
//            }
//            
//        }
//    }
//}

//
//  Provider.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

public class Provider<T>: MoyaProvider<T> where T: TargetType {
    
    init() {
        let session = Session(
            configuration: .default,
            interceptor: NetworkInterceptor()
        )
        
        super.init(
            session: session,
            plugins: [NetworkLoggerPlugin()]
        )
    }
    
    func request<D: Decodable>(_ target: T) async throws -> D {
//        throw MoyaError.statusCode(Response.init(statusCode: 401, data: Data()))
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    // 상태 코드가 2xx가 아닐 경우 예외 처리
                    guard (200...299).contains(response.statusCode) else {
                        
                        if response.statusCode == 400 {
                            let responseBody = String(data: response.data, encoding: .utf8) ?? "응답 본문을 읽을 수 X"
                            print("서버로부터 받은 오류 메시지: \(responseBody)")
                        }
                        print("상태 코드 오류: \(response.statusCode)")
                        continuation.resume(throwing: MoyaError.statusCode(response))
                        return
                    }
                    
                    do {
                        // 정상 응답이므로 데이터 디코딩 진행
                        let decodedData = try response.map(D.self)
                        continuation.resume(returning: decodedData)
                    } catch let error {
                        // 데이터 디코딩 중 오류 처리
                        if let moyaError = error as? MoyaError {
                            let networkError = NetworkError(error: moyaError)
                            continuation.resume(throwing: networkError)
                        } else {
                            Logger().error("ProviderError")
                            continuation.resume(throwing: NetworkError.unknown)
                        }
                    }
                    //                    do {
                    //                        let filterResonse = try response.filterSuccessfulStatusCodes()
                    //                        let decodedData = try filterResonse.map(D.self)
                    //                        continuation.resume(returning: decodedData)
                    //                    } catch let error  {
                    //
                    //                        if let moyaError = error as? MoyaError {
                    //                            let networkError = NetworkError(error: moyaError)
                    //                            continuation.resume(throwing: networkError)
                    //                        } else {
                    //                            Logger().error("ProviderError")
                    //                            continuation.resume(throwing: NetworkError.unknown)
                    //                        }
                    //                    }
                case .failure(let error):
                    continuation.resume(throwing: NetworkError.moyaError(error))
                }
            }
            
        }
    }
}
