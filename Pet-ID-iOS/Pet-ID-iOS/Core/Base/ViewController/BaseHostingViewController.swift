//
//  BaseHostingViewController.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 8/5/24.
//

import SwiftUI

open class BaseHostingViewController<Content>: UIHostingController<Content> where Content: View {
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
}
