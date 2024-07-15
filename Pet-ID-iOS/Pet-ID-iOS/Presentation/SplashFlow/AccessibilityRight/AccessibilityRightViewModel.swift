//
//  AccessibilityRightViewModel.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/15/24.
//

import SwiftUI
import Combine

struct AccessibilityItem: Identifiable {
    var id = UUID()
    let type: AccessType
    let title: String
    let description: String
    let isMandatory: Bool
    let icon: Image
}

enum AccessType {
    case phone, camera, gallery, notification, call
}

class AccessibilityRightViewModel: BaseViewModel {
    typealias Result = [AccessibilityItem]
    
    var result: PassthroughSubject = PassthroughSubject<Result, Never>()
    
    
    @Published var items: [AccessibilityItem] = [
        AccessibilityItem(type: .phone, title: "기기 및 앱 기록", description: "앱 서비스 최적화 및 오류 확인", isMandatory: true, icon: DSImage.phoneicon.uiImage()),
        AccessibilityItem(type: .camera, title: "카메라", description: "사진 촬영", isMandatory: false, icon: DSImage.cameraicon.uiImage()),
        AccessibilityItem(type: .gallery, title: "사진첩", description: "사진 저장", isMandatory: false, icon: DSImage.galleryicon.uiImage()),
        AccessibilityItem(type: .notification, title: "알림", description: "이벤트와 혜택 알림", isMandatory: false, icon: DSImage.notificationicon.uiImage()),
        AccessibilityItem(type: .call, title: "전화", description: "고객센터 등 연결을 위한 통화기능", isMandatory: false, icon: DSImage.callicon.uiImage())
    ]
    
}
