//
//  AccessibilityItemView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/15/24.
//

import SwiftUI

struct AccessibilityItemView: View {
    let item: AccessibilityItem
    var body: some View {
        HStack{
            ZStack {
                Circle()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.petid_lightgrey)
                    .frame(width: 50, height: 50)
                item.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            
            VStack(alignment: .leading) {
                HStack(spacing: 0){
                    if item.isMandatory {
                        Text("[필수]")
                            .foregroundColor(.petid_red)
                            .bold()
                    } else {
                        Text("[선택]")
                            .foregroundColor(.petid_title)
                            .bold()
                    }
                    Text(" \(item.title)")
                        .bold()
                }
                .font(.petIdBody2)
                
                Text(item.description)
                    .foregroundColor(.petid_grey)
                    .font(.petIdBody2)
            }
        }
    }
}

#Preview {
    AccessibilityItemView(item: AccessibilityItem( type: .phone, title: "기기 및 앱 기록", description: "앱 서비스 최적화 및 오류 확인", isMandatory: true, icon: DSImage.cameraicon.uiImage()))
}
