//
//  UserRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine

protocol UserRepository {
    func saveLikeStatus(contentId: Int, isLiked: Bool)
    func loadLikeStatus(contentId: Int) -> Bool
    
    func saveLikesCount(contentId: Int, likesCount: Int) // 좋아요 수 저장
    func loadLikesCount(contentId: Int) -> Int? // 좋아요 수 불러오기
}
