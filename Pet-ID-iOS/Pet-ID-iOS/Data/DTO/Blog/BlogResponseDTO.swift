//
//  BlogResponseDTO.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/10/24.
//

import Foundation

struct BlogResponseDTO: Decodable {
    let contentId: Int
    let title: String
    let body: String
    let category: String
    let imageUrl: String?
    let createdAt: Double
    let updatedAt: Double
    let likesCount: Int
    let authorId: Int
    let isLiked: Bool
    
    func toDomain() -> Blog {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createdAtString = dateFormatter.string(from: Date(timeIntervalSince1970: self.createdAt))
        let updatedAtString = dateFormatter.string(from: Date(timeIntervalSince1970: self.updatedAt))
        
        return Blog(contentId: self.contentId, title: self.title, body: self.body, category: self.category, imageUrl: self.imageUrl ?? "", createdAt: createdAtString, updatedAt: updatedAtString, likesCount: self.likesCount, authorId: self.authorId, isLiked: self.isLiked)
    }
    
}

struct LikeResponseDTO: Decodable {
    let contentId: Int
    let likeCount: Int
    
    
    func toDomain() -> Like {
        return Like(
            contentId: self.contentId, likeCount: self.likeCount
        )
    }
}
