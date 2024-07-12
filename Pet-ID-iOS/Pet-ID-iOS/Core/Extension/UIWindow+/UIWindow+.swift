//
//  UIWindow+.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/11/24.
//

import UIKit

extension UIWindow {
    
    /// 현재의 keyWindow를 가져옵니다.
    static var currentKeyWindow: UIWindow? {
        if #available(iOS 15, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }
}
