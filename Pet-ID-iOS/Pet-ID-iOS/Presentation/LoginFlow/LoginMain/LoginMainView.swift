//
//  LoginMainVIew.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import SwiftUI

struct LoginMainView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("간편하게 로그인하고\n펫아이디를 사용해보세요")
                Spacer()
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                ForEach(LoginButton.LoginButtonType.allCases, id: \.self) { type in
                    LoginButton(type: type, action: {
                        
                    })
                }
            }
        }
        .padding(.horizontal, 33)
        .padding(.top, 70)
        .padding(.bottom, 112)
        
        
    }
}

#Preview {
    LoginMainView()
}
