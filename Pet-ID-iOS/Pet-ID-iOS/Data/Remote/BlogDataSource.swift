//
//  BlogDataSource.swift
//  Pet-ID-iOS
//

import Foundation

protocol BlogDataSource {
    func blog(category: String) async throws -> [BlogResponseDTO]
    func detailBlog(contentId: Int) async throws -> BlogResponseDTO
    func likeContent(contentId: Int) async throws -> LikeResponseDTO
    func unlikeContent(contentId: Int) async throws -> LikeResponseDTO
    func contentImage(filePath: String) async throws -> URL
}

struct DefaultBlogDataSource: BlogDataSource {
    private let provider = Provider<BlogAPI>()
    
    func blog(category: String) async throws -> [BlogResponseDTO] {
//        Logger().debug("📡 BlogDataSource 요청 시작 - category: \(category)")
        
        let response: [BlogResponseDTO] = try await provider.request(.blog(category: category))
        
//        Logger().debug("✅ 응답 완료 - 카테고리 데이터 조회: \(category)")
        return response
    }
    
    func detailBlog(contentId: Int) async throws -> BlogResponseDTO {
        Logger().debug("📡 BlogDataSource 블로그 조회 요청 시작 - contentId: \(contentId)")
        
        let response: BlogResponseDTO = try await provider.request(.detailBlog(contentId: contentId))
        
        Logger().debug("✅ 응답 완료 - 블로그 조회: \(contentId)")
        return response
    }
    
    func likeContent(contentId: Int) async throws -> LikeResponseDTO {
//        Logger().debug("📡 BlogDataSource 좋아요 요청 시작 - contentId: \(contentId)")
        
        let response: LikeResponseDTO = try await provider.request(.likeContent(contentId: contentId))
        
//        Logger().debug("✅ 응답 완료 - 좋아요 데이터: \(response)")
        return response
    }
    
    func unlikeContent(contentId: Int) async throws -> LikeResponseDTO {
//        Logger().debug("📡 BlogDataSource 좋아요 취소 요청 시작 - contentId: \(contentId)")
        
        let response: LikeResponseDTO = try await provider.request(.unlikeContent(contentId: contentId))
        
//        Logger().debug("✅ 응답 완료 - 좋아요 취소 데이터: \(response)")
        return response
    }
    
    func contentImage(filePath: String) async throws -> URL {
//        Logger().debug("📡 BlogDataSource 이미지 URL 요청 시작 - filePath: \(filePath)")
        do {
            let responseString: String = try await provider.requestString(.contentImage(filePath: filePath))
            
            guard let url = URL(string: responseString) else {
                throw URLError(.badURL)
            }
            return url
        } catch {
//            Logger().error("❌ [BlogDataSource] 블로그 이미지 조회 실패: \(error.localizedDescription)")
            throw error
        }
    }
}
