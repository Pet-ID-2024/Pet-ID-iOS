//
//  NetworkEventLogger.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation
import Alamofire

struct NetworkEventLogger: EventMonitor {
    let queue: DispatchQueue = DispatchQueue(label: "NetworkEventLogger")
    
    func requestDidFinish(_ request: Request) {
        
        let url = request.request?.url?.absoluteString ?? ""
        let method = request.request?.httpMethod ?? ""
        let headers = "\(request.request?.allHTTPHeaderFields ?? [:])"
        var requestBody: [String: Any] = [:]
        
        if let httpbody = request.request?.httpBody {
            if let json = try? JSONSerialization.jsonObject(with: httpbody, options: []) as? [String: Any] {
                requestBody = json
            }
        }
        
        print(
            "\n" +
            "🛰 NETWORK Reqeust LOG \n"
            + "Method: \(method)\n"
            + "Header: \(headers)\n"
            + "RequestBody: \(requestBody)\n"
        )
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
            print(
                "\n" +
                "🛰 NETWORK Response LOG\n"
                +
                "URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
                    + "Result: " + "\(response.result)" + "\n"
                    + "StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
                    + "Data: \(response.data?.toPrettyPrintedString ?? "")"
            )
        }
}

extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(
                data: data,
                encoding: String.Encoding.utf8.rawValue
              ) else { return nil }
        return prettyPrintedString as String
    }
}
