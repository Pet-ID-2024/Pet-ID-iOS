////
////  TestFetcher.swift
////  Pet-ID-iOS
////
////  Created by 박호건 on 11/14/24.
////
//
//import Foundation
//
//protocol TestFetcher {
//    func imageUrl(filePath: String) async throws -> ImageModel
//}
//
//struct DefaultTestFetcher: TestFetcher {
//    
//    private let repository: TestRepository
//    
//    init(repository: TestRepository = DefaultTestRepository()) {
//        self.repository = repository
//    }
//    
//    func imageUrl(filePath: String) async throws -> ImageModel {
//        Logger().debug("🟢 TestFetcher 호출 - filePath: \(filePath)")
//        do {
//            let image = try await repository.imageUrl(filePath: filePath)
//            Logger().debug("✅ TestFetcher 응답 완료 - 배너 데이터 수: \(filePath.count)")
//            return image
//        }catch{
//            Logger().error("❌ TestFetcher 오류 발생: \(error.localizedDescription)")
//            throw error
//        }
//    }
//}
//
