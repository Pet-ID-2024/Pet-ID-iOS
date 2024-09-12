//
//  Notification.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 9/11/24.
//

import SwiftUI

struct Notification: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button {
                    
                } label: {
                    DSImage.chevronicon.toImage()
                        .font(.petIdChevron)
                        .foregroundColor(.black)
                }
                .padding(.leading, -150)
                
                    Text("알림")
            }
            .padding()
            
            Spacer()
            
            
        }
    }
}

#Preview {
    Notification()
}
