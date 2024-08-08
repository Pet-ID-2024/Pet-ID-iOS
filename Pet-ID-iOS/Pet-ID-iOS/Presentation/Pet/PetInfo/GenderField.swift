//
//  GenderField.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/1/24.
//

import SwiftUI

struct GenderField: View {
    @Binding var gender: String
    @Binding var focusedField: PetInfoViewModel.Field?

    var body: some View {
        VStack(alignment: .leading) {
            Text("성별")
                .font(.headline)
                .padding(.bottom, 4)

            HStack(spacing: 30) {
                genderButton(title: "남", selectedGender: "남")
                genderButton(title: "여", selectedGender: "여")
            }
        }
    }
    
    private func genderButton(title: String, selectedGender: String) -> some View {
        Button(action: {
            gender = selectedGender
            focusedField = .gender
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(gender == selectedGender ? Color.blue : Color.gray, lineWidth: 1)
                )
                .foregroundColor(gender == selectedGender ? .blue : .black)
        }
    }
}

