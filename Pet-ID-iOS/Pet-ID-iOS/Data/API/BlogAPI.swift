//
//  BlogAPI.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/10/24.
//

import Foundation
import Moya

enum BlogAPI: BaseTargetType {
    case blog(category: String)
    case detailBlog(contentId: Int)
    case likeContent(contentId: Int)
    case unlikeContent(contentId: Int)
    case contentImage(filePath: String)
    
    var path: String {
        switch self {
        case .blog:
            return "/v1/content"
        case .detailBlog(let contentId):
            return "/v1/content/\(contentId)"
        case .likeContent(let contentId), .unlikeContent(let contentId):
            return "/v1/content/\(contentId)/like"
        case .contentImage:
            return "/v1/content/presigned-get-url"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .blog, .detailBlog, .contentImage:
            return .get
        case .likeContent:
            return .post
        case .unlikeContent:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .blog(let category):
            let parameters: [String: Any] = [
                "category": category.uppercased()
            ]
//            print("BlogAPI 요청 파라미터: \(parameters)")
//            print("BlogAPI 요청 경로: \(baseURL)\(path)")
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .likeContent(let contentId), .unlikeContent(let contentId), .detailBlog(let contentId):
            return .requestPlain
        case .contentImage(let filePath):
            let cleanFilePath = filePath.removingPercentEncoding ?? filePath
            return .requestParameters(parameters: ["filePath": cleanFilePath], encoding: URLEncoding.queryString)
        }
    }
}
