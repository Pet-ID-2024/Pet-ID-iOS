//
//  Blog.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/10/24.
//

import Foundation

struct Blog {
    let contentId: Int
    let title: String
    let body: String
    let category: String
    var imageUrl: String
    let createdAt: String
    let updatedAt: String
    var likesCount: Int
    let authorId: Int
    var isLiked: Bool
}

struct Like {
    let contentId: Int
    let likeCount: Int
}


