//
//  Complete.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 6/11/24.
//

import SwiftUI

struct Complete: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                Image("CheckImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .padding()
                
                Text("신청이 완료되었습니다!")
                    .font(.system(size: 24, weight: .bold))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    DetailInfoView(label: "이름", value: "덕구")
                    DetailInfoView(label: "생일", value: "2022.03.02")
                    DetailInfoView(label: "성별", value: "남, 중성화x")
                    DetailInfoView(label: "품종", value: "믹스 푸들")
                    DetailInfoView(label: "특징", value: "갈색, 곱슬, 장모")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("다음")
                }
            }
        }
        .padding()
    }
}

#Preview {
    Complete()
}
