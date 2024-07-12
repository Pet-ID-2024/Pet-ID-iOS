//
//  UserServiceTerms.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import Foundation

protocol ServiceTermsType {
    var tag: AnyHashable { get }
    var title: String { get }
    var toURL: URL? { get }
    var agreementType: AgreementType { get }
}

extension ServiceTermsType {
    var tag: AnyHashable {
        return UUID().uuidString
    }
}

enum UserServiceTerms: ServiceTermsType, CaseIterable {
    
    case privacyCollectionUsage
    case privacyThirdPartyProvision
    case marketingInfoReception
    
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
    
    var agreementType: AgreementType {
        switch self {
        case .privacyCollectionUsage: return .required
        case .privacyThirdPartyProvision: return .required
        case .marketingInfoReception: return .optional
        }
    }
}
