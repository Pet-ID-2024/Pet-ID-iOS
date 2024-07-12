//
//  Provider.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

enum NetworkError: Error {
    case statusCode(Int)
    case accessTokenExpired
    case decode
    case underlying(Error)
}

public class Provider<T: TargetType>: MoyaProvider<T> {
    
    private let logger = Logger()
    
    init() {
        let session = Session(
            configuration: .default,
            interceptor: NetworkInterceptor(),
            eventMonitors: [NetworkEventLogger()]
        )
        super.init(session: session)
    }
    
    func request<D>(_ target: T) async -> Result<D, NetworkError> where D: Decodable {
        await withCheckedContinuation { continuation in
            self.request(target) { [weak self] result in
                
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(D.self, from: response.data)
                        continuation.resume(returning: .success(decodedData))
                    } catch {
                        
                        let statusCode = response.statusCode
                        
                        if statusCode == 200 {
                            self?.logger.warning(
                                "Failed Decode\n"
                                + "type: \(D.self)"
                                + "response: \(response.data)"
                            )
                            continuation.resume(returning: .failure(.decode))
                        } else {
                            continuation.resume(returning: .failure(.statusCode(statusCode)))
                        }
                        
                    }
                case .failure(let error):
                    
                    switch error {
                        
                    default:
                        continuation.resume(returning: .failure(.underlying(error)))
                    }
                }
            }
        }
    }
}
