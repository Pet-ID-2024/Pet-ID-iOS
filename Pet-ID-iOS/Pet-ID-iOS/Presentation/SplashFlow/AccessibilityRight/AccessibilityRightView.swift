//
//  AccessibilityRightView.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 7/15/24.
//

import SwiftUI

struct AccessibilityRightView: View {
    @ObservedObject var viewModel: AccessibilityRightViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text("접근성 설정 안내")
                    .font(.petIdTitle1)
                    .foregroundStyle(Color.petid_title)
                
                Spacer()
                    .frame(height: 8)
                
                Text("PET ID 고객님의 편리한 앱 이용을 위해 다음의 접근 권한이 필요합니다.")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.petIdBody2)
                    .foregroundColor(.petid_grey)

                Spacer()
                    .frame(height: 20)
                
                Divider()
                    .padding(.bottom, 20)
                
                ForEach(viewModel.items) { item in
                    AccessibilityItemView(item: item)
                        .padding(.bottom, 15)
                }
                
            }
            
            VStack(spacing: 0){
                
                VStack(alignment: .leading){
                    HStack {
                        DSImage.infoicon.toImage()
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("접근권한 변경 방법")
                            .foregroundStyle(Color.petid_title)
                            .font(.petIdBody2)
                        
                        Spacer()
                    }
                    Text("설정>애플리케이션관리자>PETID")
                        .font(.petIdBody3)
                        .foregroundColor(.petid_subtitle)
                }
                .padding()
                .background(
                    Rectangle()
                        .foregroundColor(.petid_lightgrey)
                        .cornerRadius(10)
                )
                
                Spacer()
                    .frame(height: 14)
                
                Text("선택적 접근권한은 동의하지 않아도 해당기능 외 앱 이용이 가능합니다.")
                    .font(.petIdBody2)
                    .foregroundColor(.petid_subtitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    UserDefaultManager.shared.isFirstExecute = false
                    viewModel.result.send(())
                }) {
                    Text("확인")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal, 33)
        .padding(.vertical, 15)
    }
}

#Preview {
    AccessibilityRightView(viewModel: .init())
}
