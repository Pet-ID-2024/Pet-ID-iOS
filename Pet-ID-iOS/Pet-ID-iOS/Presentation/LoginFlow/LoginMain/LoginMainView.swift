//
//  LoginMainVIew.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/8/24.
//

import SwiftUI

struct LoginMainView: View {
    
    @ObservedObject var viewModel: LoginMainViewModel
    private var appleAuthProvider = AppleAuthProvider(window: UIWindow.currentKeyWindow)
    
    init(viewModel: LoginMainViewModel) {
        self.viewModel = viewModel
    }
    
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
                        switch type {
                        case .apple: appleAuthProvider.startAppleLogin { credential, error in
                            if let error = error {
                                return
                            }
                            
                            if let credential = credential {
                                viewModel.runAppleLogin(credential: credential)
                            }
                        }
                        case .google: break
                        case .kakao: break
                        case .naver: break
                        }
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
    LoginMainView(viewModel: LoginMainViewModel())
}
