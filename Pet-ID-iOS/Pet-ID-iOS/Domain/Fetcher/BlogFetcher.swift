//
//  BlogFetcher.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 11/10/24.
//

import Foundation

protocol BlogFetcher {
    func blog(category: String) async throws -> [Blog]
    func detailBlog(contentId: Int) async throws -> Blog
    func likeContent(contentId: Int) async throws -> Like
    func unlikeContent(contentId: Int) async throws -> Like
    func contentImage(filePath: String) async throws -> URL
}

struct DefaultBlogFetcher: BlogFetcher {
    private let repository: BlogRepository
    
    init(repository: BlogRepository = DefaultBlogRepository()) {
        self.repository = repository
    }
    
    func blog(category: String) async throws -> [Blog] {
//        Logger().debug("🟢 BlogFetcher 호출 - category: \(category)")
        
        do {
            let contents = try await repository.blog(category: category)
//            Logger().debug("✅ BlogFetcher 응답 완료 - 콘텐츠 목록 조회 성공: \(contents)")
            return contents
        } catch {
            Logger().error("❌ BlogFetcher 오류 발생: \(error.localizedDescription)")
            throw error
        }
    }
    
    func detailBlog(contentId: Int) async throws -> Blog {
//        Logger().debug("🟢 BlogFetcher 호출 - 조회 기능, contentId: \(contentId)")
        
        do {
            let detail = try await repository.detailBlog(contentId: contentId)
//            Logger().debug("✅ BlogFetcher 응답 완료 - 조회 기능 성공: \(detail)")
            return detail
        } catch {
            Logger().error("❌ BlogFetcher 오류 발생 - 조회 기능: \(error.localizedDescription)")
            throw error
        }
    }
    
    func likeContent(contentId: Int) async throws -> Like {
//        Logger().debug("🟢 BlogFetcher 호출 - 좋아요 기능, contentId: \(contentId)")
        
        do {
            let like = try await repository.likeContent(contentId: contentId)
//            Logger().debug("✅ BlogFetcher 응답 완료 - 좋아요 기능 성공: \(like)")
            return like
        } catch {
            Logger().error("❌ BlogFetcher 오류 발생 - 좋아요 기능: \(error.localizedDescription)")
            throw error
        }
    }
    
    func unlikeContent(contentId: Int) async throws -> Like {
//        Logger().debug("🟢 BlogFetcher 호출 - 좋아요 취소 기능, contentId: \(contentId)")
        
        do {
            let unlike = try await repository.unlikeContent(contentId: contentId)
//            Logger().debug("✅ BlogFetcher 응답 완료 - 좋아요 취소 기능 성공: \(unlike)")
            return unlike
        } catch {
            Logger().error("❌ BlogFetcher 오류 발생 - 좋아요 취소 기능: \(error.localizedDescription)")
            throw error
        }
    }
    
    func contentImage(filePath: String) async throws -> URL {
//        Logger().debug("🟢 BlogFetcher 호출 - 이미지 URL 가져오기, filePath: \(filePath)")
        
        do {
            let imageURL = try await repository.contentImage(filePath: filePath)
//            Logger().debug("✅ BlogFetcher 응답 완료 - 이미지 URL: \(imageURL)")
            return imageURL
        } catch {
            Logger().error("❌ BlogFetcher 오류 발생 - 이미지 URL 가져오기, filePath: \(filePath), 오류: \(error.localizedDescription)")
            throw error
        }
    }
}
