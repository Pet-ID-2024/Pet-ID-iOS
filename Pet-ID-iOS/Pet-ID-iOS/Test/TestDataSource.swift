////
////  TestDataSource.swift
////  Pet-ID-iOS
////
////  Created by 박호건 on 11/14/24.
////
//
//import Foundation
//import Moya
//
//protocol TestDataSource {
//    func imageUrl(filePath: String) async throws -> ImageModel
//}
//
//struct DefaultTestDataSource: TestDataSource {
//    
//    private let provider = Provider<TestAPI>()
//    
//    func imageUrl(filePath: String) async throws -> ImageModel {
//        Logger().debug("📡 TestDataSource 요청 시작 - filePath: \(filePath)")
//        
//        do {
//            // provider 요청을 통해 TestResponseDTO를 받아옵니다.
//            let response: TestResponseDTO = try await provider.request(.imageURL(filePath: filePath))
//            
//            Logger().debug("✅ TestDataSource 응답 완료 - 파일 경로: \(filePath), 응답: \(response.imageUrl)")
//            
//            return response.toDomain()
//            
//        } catch let error as MoyaError {
//            // MoyaError 유형을 세부적으로 처리하여 더 구체적인 오류 메시지를 기록
//            switch error {
//            case .underlying(let nsError as NSError, _):
//                Logger().error("❌ TestDataSource 오류 발생 - filePath: \(filePath), NSError code: \(nsError.code), description: \(nsError.localizedDescription)")
//            default:
//                Logger().error("❌ TestDataSource 오류 발생 - filePath: \(filePath), MoyaError: \(error.localizedDescription)")
//            }
//            throw error
//        } catch {
//            // 알 수 없는 에러의 경우 일반적인 에러 메시지와 함께 전달
//            Logger().error("❌ TestDataSource 오류 발생 - filePath: \(filePath), 알 수 없는 에러: \(error.localizedDescription)")
//            throw error
//        }
//    }
//}
