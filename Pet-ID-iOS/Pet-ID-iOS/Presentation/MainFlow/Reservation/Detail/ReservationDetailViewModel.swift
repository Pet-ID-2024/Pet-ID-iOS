import Foundation
import Combine

enum ReservationDetailState: String {
    case reservation
    case back
}

class ReservationDetailViewModel: BaseViewModel<ReservationDetailState> {
    @Published var hospital: Hospital
    @Published var processedImageUrls: [String] = [] // Presigned URL로 변환된 이미지 리스트

    private let hospitalFetcher: HospitalFetcher

    init(hospital: Hospital, hospitalFetcher: HospitalFetcher = DefaultHospitalFetcher()) {
        self.hospital = hospital
        self.hospitalFetcher = hospitalFetcher
        super.init()
        processImageUrls()
    }

    // MARK: - Presigned URL 처리
    private func processImageUrls() {
        Task {
            do {
                let updatedUrls = try await withThrowingTaskGroup(of: String.self) { group in
                    for imageUrl in hospital.imageUrl ?? [] {
                        group.addTask {
                            try await self.fetchPresignedUrl(for: imageUrl)
                        }
                    }
                    return try await group.reduce(into: [String]()) { result, url in
                        result.append(url)
                    }
                }
                
                DispatchQueue.main.async {
                    self.processedImageUrls = updatedUrls
                    Logger().debug("✅ Presigned URL 처리 완료: \(updatedUrls)")
                }
            } catch {
                Logger().error("❌ Presigned URL 처리 실패: \(error.localizedDescription)")
            }
        }
    }

    private func fetchPresignedUrl(for filePath: String) async throws -> String {
        do {
            let presignedUrl = try await hospitalFetcher.hospitalImage(filePath: filePath)
            return presignedUrl?.absoluteString ?? ""
        } catch {
            throw error
        }
    }

    // MARK: - 예약 처리
    func reservation() {
        result.send(.reservation)
    }

    // MARK: - 뒤로가기 처리
    func navigateBack() {
        result.send(.back)
    }
}
