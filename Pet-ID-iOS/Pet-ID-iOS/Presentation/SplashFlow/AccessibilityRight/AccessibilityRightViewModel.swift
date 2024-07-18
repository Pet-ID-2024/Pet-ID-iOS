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

class AccessibilityRightViewModel: BaseViewModel<Void> {
    typealias Result = [AccessibilityItem]
    
    @Published var items: [AccessibilityItem] = [
        AccessibilityItem(type: .phone, title: "기기 및 앱 기록", description: "앱 서비스 최적화 및 오류 확인", isMandatory: true, icon: DSImage.phoneicon.toImage()),
        AccessibilityItem(type: .camera, title: "카메라", description: "사진 촬영", isMandatory: false, icon: DSImage.cameraicon.toImage()),
        AccessibilityItem(type: .gallery, title: "사진첩", description: "사진 저장", isMandatory: false, icon: DSImage.galleryicon.toImage()),
        AccessibilityItem(type: .notification, title: "알림", description: "이벤트와 혜택 알림", isMandatory: false, icon: DSImage.notificationicon.toImage()),
        AccessibilityItem(type: .call, title: "전화", description: "고객센터 등 연결을 위한 통화기능", isMandatory: false, icon: DSImage.callicon.toImage())
    ]
    
}
