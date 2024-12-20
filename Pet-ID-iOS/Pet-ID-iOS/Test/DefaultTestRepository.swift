////
////  DefaultTestRepository.swift
////  Pet-ID-iOS
////
////  Created by 박호건 on 11/14/24.
////
//
//import Foundation
//
//struct DefaultTestRepository: TestRepository {
//    
//    let dataSource: TestDataSource
//    
//    init(dataSource: TestDataSource = DefaultTestDataSource()) {
//        self.dataSource = dataSource
//    }
//    
//    func imageUrl(filePath: String) async throws -> ImageModel {
//        do {
//            let url = try await dataSource.imageUrl(filePath: filePath)
//            Logger().debug("이미지 URL 가져오기 성공!")
//            return url
//        } catch {
//            Logger().error("이미지 URL 가져오기 실패 \(error.localizedDescription)")
//            throw error
//        }
//    }
//}
