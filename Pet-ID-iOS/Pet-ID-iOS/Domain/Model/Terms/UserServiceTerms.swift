//
//  UserServiceTerms.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

// 서비스 약관 정보 제공 프로토콜
protocol ServiceTermsType {
    var tag: AnyHashable { get } // 고유 식별자
    var title: String { get } // 약관의 제목
    var toURL: URL? { get } // 약관에 대한 URL
    var agreementType: AgreementType { get } // 동의서 종류
    var subTitle: String { get } // 추가 설명
}

extension ServiceTermsType {
    var tag: AnyHashable {
        return UUID().uuidString
    }
}

// 사용자 서비스 약관을 정의하는 열거형
enum UserServiceTerms: ServiceTermsType, CaseIterable {
    
    case privacyCollectionUsage // 개인정보 수집 및 이용
    case privacyThirdPartyProvision // 개인정보 제3자 제공
    case marketingInfoReception // 광고성 정보 수신
    
    // 약관의 제목 반환
    var title: String {
        switch self {
        case .privacyCollectionUsage:
            return "개인정보 수집 및 이용동의(\(self.agreementType.title))"
        case .privacyThirdPartyProvision:
            return "개인정보 제3자 제공 동의(\(self.agreementType.title))"
        case .marketingInfoReception:
            return "광고성 정보 수신동의(\(self.agreementType.title))"
        }
    }
    
    var toURL: URL? {
        return nil
    }
    
    // 각 약관의 동의서 종류를 반환
    var agreementType: AgreementType {
        switch self {
        case .privacyCollectionUsage: return .required
        case .privacyThirdPartyProvision: return .required
        case .marketingInfoReception: return .optional
        }
    }
    
    // 각 약관에 대한 추가 설명을 반환
    var subTitle: String {
        switch self {
        case .marketingInfoReception:
            return "다양한 혜택과 신규 소식을 보내드립니다."
        default:
            return ""
        }
    }
}
