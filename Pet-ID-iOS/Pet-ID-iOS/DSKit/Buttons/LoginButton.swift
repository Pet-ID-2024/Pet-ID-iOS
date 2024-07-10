//
//  LoginButton.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/10/24.
//

import SwiftUI

struct LoginButton: View {
    
    enum LoginButtonType: CaseIterable {
        case kakao
        case naver
        case google
        case apple
        
        var leftImageName: String {
            switch self {
            case .kakao:
                return "kakao"
            case .naver:
                return "naver"
            case .google:
                return "google"
            case .apple:
                return "apple"
            }
        }
        
        var bgColor: Color {
            switch self {
            case .kakao:
                return .init(hex: "FEE500")
            case .naver:
                return .init(hex: "2CC623")
            case .google:
                return .white
            case .apple:
                return .black
            }
        }
        
        var layerColor: Color {
            switch self {
            case .kakao, .naver, .apple:
                return .clear
            case .google:
                return .init(hex: "D9D9D9")
            }
        }
        
        var textColor: Color {
            switch self {
            case .kakao, .google:
                return .black
            case .naver, .apple:
                return .white
            }
        }
        
        var title: String {
            switch self {
            case .kakao:
                return "카카오로 계속하기"
            case .naver:
                return "네이버로 계속하기"
            case .google:
                return "Google로 계속하기"
            case .apple:
                return "Apple로 계속하기"
            }
        }
    }
    
    @State private var type: LoginButtonType
    private let action: (() -> ())
    
    init(type: LoginButtonType, action: @escaping (() -> ())) {
        self.type = type
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            
            HStack {
                Image(type.leftImageName)
                
                Spacer()
                
                Text(type.title)
                    .foregroundStyle(type.textColor)
                
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.vertical, 16)
            .background(
                type.bgColor
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(type.layerColor, lineWidth: 1)
                    .foregroundStyle(.clear)
            )
        })
    }
}

#Preview {
    LoginButton(type: .google, action: { })
}
