//
//  NetworkPlugin.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/18/24.
//

import Foundation
import Moya

// 네트워크 요청 및 응답을 로깅하는 플러그인
struct NetworkLoggerPlugin: PluginType {
    
    // 요청 결과를 수신했을 때 호출되는 메서드
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            onSuceed(response, target: target, isFromError: false) // 성공 시 응답 처리
        case .failure(let failure):
            // 실패 처리(optional)
            break
        }
    }
    
    // 성공적인 응답을 로깅
    func onSuceed(_ response: Response, target: TargetType, isFromError: Bool) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode
        var httpHeader: String = ""
        
        // 응답 헤더를 문자열로 변환
        response.response?.allHeaderFields.forEach {
            httpHeader.append("     \($0): \($1)\n")
        }
        
        var responseDataLog: String = ""
        
        // 응답 데이터를 문자열로 변환
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
