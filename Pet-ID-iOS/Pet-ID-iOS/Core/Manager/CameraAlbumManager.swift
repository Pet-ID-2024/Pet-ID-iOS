//
//  CameraAlbumManager.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/10/24.
//

import Foundation
import Photos
import Combine
import AVFoundation

// 카메라 및 앨범 접근 권한을 접근하는 싱글톤 클래스
final class CameraAlbumManager {
    
    // 공유 인스턴스
    static let shared = CameraAlbumManager()
    
    private init() { }
    
    // 앨범 접근 권한 요청 메서드
    @discardableResult
    func requestAlbumAuthorization() -> AnyPublisher<Bool, Never> {
        // 권한 상태에 따라 Publisher를 반환
        let status = PHPhotoLibrary.authorizationStatus() // 현재 앨범 권한 상태 확인
        
        switch status {
            
        case .notDetermined:
            // 권한 요청이 결정되지 않은 경우, 요청 후 결과 반환
            return Future<Bool, Never> { promise in
                PHPhotoLibrary.requestAuthorization {  newStatus in
                    promise(.success(newStatus == .authorized)) // 요청 결과에 따라 true/false 반환
                }
            }.eraseToAnyPublisher()
            
        case .restricted, .denied:
            // 권환이 제한되거나 거부된 경우 false 반환
            return Just(false).eraseToAnyPublisher()
            
        case .authorized, .limited:
            // 권한이 승인된 경우 true 반환
            return Just(true).eraseToAnyPublisher()
            
        @unknown default:
            // 알 수 없는 상태일 경우 false 반환
            return Just(false).eraseToAnyPublisher()
        }
    }
    
    // 카메라 접근 권한 요청 메서드
    @discardableResult
    func requestCameraAuthorization() -> AnyPublisher<Bool, Never> {
        // 권한 상태에 따라 Publisher를 반환
        let status = AVCaptureDevice.authorizationStatus(for: .video) // 현재 카메라 권한 상태 확인
        
        switch status {
        case .notDetermined:
            // 권한 요청이 결정되지 않은 경우, 요청 후 결과 반환
            return Future<Bool, Never> { promise in
                AVCaptureDevice.requestAccess(for: .video) {  result in
                    promise(.success(result)) // 요청 결과에 따라 true/false 반환
                }
            }.eraseToAnyPublisher()
            
        case .restricted, .denied:
            // 권한이 제한되거나 거부된 경우 false 반환
            return Just(false).eraseToAnyPublisher()

        case .authorized:
            // 권한이 승인된 경우 true 반환
            return Just(true).eraseToAnyPublisher()
            
        @unknown default:
            // 알 수 없는 상태일 경우 false 반환
            return Just(false).eraseToAnyPublisher()
        }
    }
}
