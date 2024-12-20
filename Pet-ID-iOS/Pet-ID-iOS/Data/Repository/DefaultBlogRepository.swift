//
//  DefaultBlogRepository.swift
//  Pet-ID-iOS
//

import Foundation

struct DefaultBlogRepository: BlogRepository {
    
    let dataSource: BlogDataSource
    
    init(dataSource: BlogDataSource = DefaultBlogDataSource()) {
        self.dataSource = dataSource
    }
    
    func blog(category: String) async throws -> [Blog] {
        do {
            //            Logger().debug("📡 Repository 요청 시작 - category: \(category)")
            
            let contents = try await dataSource.blog(category: category).map { $0.toDomain() }
            
            //            Logger().debug("✅ Repository 응답 완료 - 블로그 조회: \(contents)")
            return contents
        } catch {
            Logger().error("❌ Repository 오류 발생: category: \(category) \(error.localizedDescription)")
            throw error
        }
    }
    
    func detailBlog(contentId: Int) async throws -> Blog {
        do {
            Logger().debug("📡 Repository 요청 시작 - 조회 기능, contentId: \(contentId)")
            
            let detail = try await dataSource.detailBlog(contentId: contentId).toDomain()
            
            return detail
        } catch {
            Logger().error("❌ Repository 오류 발생 - 조회 기능, contentId: \(contentId), 오류: \(error.localizedDescription)")
            throw error
        }
    }
    
    // 좋아요 기능 추가
    func likeContent(contentId: Int) async throws -> Like {
        do {
//            Logger().debug("📡 Repository 요청 시작 - 좋아요 기능, contentId: \(contentId)")
            
            let like = try await dataSource.likeContent(contentId: contentId).toDomain()
            
            return like
        } catch {
            Logger().error("❌ Repository 오류 발생 - 좋아요 기능, contentId: \(contentId), 오류: \(error.localizedDescription)")
            throw error
        }
    }
    
    // 좋아요 취소 기능 추가
    func unlikeContent(contentId: Int) async throws -> Like {
        do {
//            Logger().debug("📡 Repository 요청 시작 - 좋아요 취소 기능, contentId: \(contentId)")
            
            let unlike = try await dataSource.unlikeContent(contentId: contentId).toDomain()
            
            return unlike
        } catch {
            Logger().error("❌ Repository 오류 발생 - 좋아요 취소 기능, contentId: \(contentId), 오류: \(error.localizedDescription)")
            throw error
        }
    }
    
    func contentImage(filePath: String) async throws -> URL {
        return try await dataSource.contentImage(filePath: filePath)
    }
}
