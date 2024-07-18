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
        return try await withCheckedThrowingContinuation { continuation in
            super.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let filterResonse = try response.filterSuccessfulStatusCodes()
                        let decodedData = try filterResonse.map(D.self)
                        continuation.resume(returning: decodedData)
                    } catch let error  {
                        
                        if let moyaError = error as? MoyaError {
                            let networkError = NetworkError(error: moyaError)
                            continuation.resume(throwing: networkError)
                        } else {
                            Logger().error("ProviderError")
                            continuation.resume(throwing: NetworkError.unknown)
                        }
                    }
                case .failure(let error):
                    continuation.resume(throwing: NetworkError.moyaError(error))
                }
            }
            
        }
    }
}
