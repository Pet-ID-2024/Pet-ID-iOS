//
//  NetworkEventLogger.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Moya

// 네트워크 요청의 로깅을 담당하는 Moya 플러그인
struct V2NetworkLoggerPlugin: PluginType {
    
    // 응답을 수신한 후 호출되는 메서드
    // result: 요청 결과(성공 or 실패)
    // target: 요청 대상
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            // 요청 성공적으로 완료 된 경우 onSucced 메서드 호출
            onSuceed(response, target: target, isFromError: false)
        case .failure(let failure):
            // 실패한 경우 별도로 처리 x
            break
        }
    }
    
    // 성공적인 응답을 처리하는 메서드
    // response: 성공적인 응답
    // target: 요청 대상
    // isFromError: 오류로부터의 응답 여부
    func onSuceed(_ response: Response, target: TargetType, isFromError: Bool) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil" // 요청 url
        let statusCode = response.statusCode // 상태 코드
        var httpHeader: String = ""
        
        // 응답의 모든 HTTP 헤더 기록
        response.response?.allHeaderFields.forEach {
            httpHeader.append("     \($0): \($1)\n")
        }
        
        var responseDataLog: String = ""
        
        // 응답 데이터를 문자열로 변환해 기록
        if let responseString = String(
            bytes: response.data,
            encoding: .utf8
        ) {
            responseDataLog.append("\(responseString)\n")
        }
        
        // 로그 출력
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
