//
//  BlogRepository.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/10/24.
//

import Foundation

protocol BlogRepository {
    func blog(category: String) async throws -> [Blog]
    func detailBlog(contentId: Int) async throws -> Blog
    func likeContent(contentId: Int) async throws -> Like
    func unlikeContent(contentId: Int) async throws -> Like
    func contentImage(filePath: String) async throws -> URL
}
