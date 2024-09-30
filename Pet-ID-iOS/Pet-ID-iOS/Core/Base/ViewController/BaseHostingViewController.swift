//
//  BaseHostingViewController.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/5/24.
//

import SwiftUI

open class BaseHostingViewController<Content>: UIHostingController<Content> where Content: View {
    // 뷰가 로드될 때 호출되는 메서드
    open override func viewDidLoad() {
        super.viewDidLoad() // 상위 클래스의 viewDidLoad 호출
    }
}
