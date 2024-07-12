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

final class CameraAlbumManager {
    
    static let shared = CameraAlbumManager()
    
    private init() { }
    
    @discardableResult
    func requestAlbumAuthorization() -> AnyPublisher<Bool, Never> {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
            
        case .notDetermined:
            return Future<Bool, Never> { promise in
                PHPhotoLibrary.requestAuthorization {  newStatus in
                    promise(.success(newStatus == .authorized))
                }
            }.eraseToAnyPublisher()
            
        case .restricted, .denied:
            return Just(false).eraseToAnyPublisher()
            
        case .authorized, .limited:
            return Just(true).eraseToAnyPublisher()
            
        @unknown default:
            return Just(false).eraseToAnyPublisher()
        }
    }
    
    @discardableResult
    func requestCameraAuthorization() -> AnyPublisher<Bool, Never> {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined:
            return Future<Bool, Never> { promise in
                AVCaptureDevice.requestAccess(for: .video) {  result in
                    promise(.success(result))
                }
            }.eraseToAnyPublisher()
            
        case .restricted, .denied:
            return Just(false).eraseToAnyPublisher()

        case .authorized:
            return Just(true).eraseToAnyPublisher()
            
        @unknown default:
            return Just(false).eraseToAnyPublisher()
        }
    }
}
