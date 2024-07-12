//
//  AccessibilityGuideView.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/9/24.
//

import SwiftUI

struct AccessibilityGuideView: View {
    var body: some View {
        
        VStack {
            
            Button(action: {
                UserDefaultManager.shared.isFirstExecute = false
            }, label: {
                Text("확인")
            })
        }
    }
}


