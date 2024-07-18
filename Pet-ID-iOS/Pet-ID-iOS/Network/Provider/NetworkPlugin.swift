//
//  NetworkPlugin.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation
import Moya

struct NetworkLoggerPlugin: PluginType {
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            onSuceed(response, target: target, isFromError: false)
        case .failure(let failure):
            break
        }
    }
    
    func onSuceed(_ response: Response, target: TargetType, isFromError: Bool) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode
        var httpHeader: String = ""
        
        response.response?.allHeaderFields.forEach {
            httpHeader.append("     \($0): \($1)\n")
        }
        
        var responseDataLog: String = ""
        
        if let responseString = String(
            bytes: response.data,
            encoding: .utf8
        ) {
            responseDataLog.append("\(responseString)\n")
        }
        
        print(
            "\n" +
            "🛰 V2 NETWORK Response LOG \n"
            + "URL: \(url)\n"
            + "StatusCode: \(statusCode)\n"
            + "HTTPHeader: \n\(httpHeader)\n"
            + "ResponseDataLog: \(responseDataLog)"
            + "\n[HTTP Response End]\n"
        )
        
    }
    
}
