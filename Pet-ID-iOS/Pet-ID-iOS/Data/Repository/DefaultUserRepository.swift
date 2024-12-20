//
//  UserRepository.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Combine


struct DefaultUserRepository: UserRepository {
    private let userDefaults = UserDefaults.standard
    
    func saveLikeStatus(contentId: Int, isLiked: Bool) {
        userDefaults.set(isLiked, forKey: "isLiked_\(contentId)")
    }
    
    func loadLikeStatus(contentId: Int) -> Bool {
        return userDefaults.bool(forKey: "isLiked_\(contentId)")
    }
    
    func saveLikesCount(contentId: Int, likesCount: Int) {
        userDefaults.set(likesCount, forKey: "likesCount_\(contentId)")
    }
    
    func loadLikesCount(contentId: Int) -> Int? {
        return userDefaults.value(forKey: "likesCount_\(contentId)") as? Int
    }
}
