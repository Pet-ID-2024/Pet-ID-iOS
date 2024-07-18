//
//  IsEnablePetButton.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/16/24.
//

import SwiftUI

struct IsEnablePetButton: View {
    
    var title: String
    @Binding var isEnabled: Bool
    var action: (() -> ())
    
    init(
        title: String,
        isEnabled: Binding<Bool>,
        action: @escaping () -> Void
    ) {
        self.title = title
        self._isEnabled = isEnabled
        self.action = action
    }
    
    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(isEnabled ? .blue : .gray)
                    Text(title)
                        .foregroundStyle(.white)
                }
            }
        )
    }
}

#Preview {
    IsEnablePetButton(
        title: "아몰랑",
        isEnabled: .constant(false),
        action: {
            
        }
    )
    .frame(height: 40)
    .frame(width: 100)
}
