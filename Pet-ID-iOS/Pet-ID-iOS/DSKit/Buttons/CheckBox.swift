//
//  CheckBox.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/12/24.
//

import SwiftUI

struct CheckBox: View {
    
    @Binding var isChecked: Bool
    
    var size: CGFloat = 24
    
    var body: some View {
        ZStack {
            if isChecked {
                Image("checkicon")
                    .resizable()
                    .scaledToFit()
                    .transition(.opacity)
                
            } else {
                Image("checkbtn")
                    .transition(.scale)
            }
        }
        .frame(width: size, height: size)
        .onTapGesture {
            withAnimation {
                isChecked.toggle()
            }
        }
    }
}

#Preview {
    @State var isChecked: Bool = false
    return CheckBox(isChecked: $isChecked, size: 24)
}
