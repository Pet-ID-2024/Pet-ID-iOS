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
                .font(.body4_med)
//                .fontWeight(.medium)
                .foregroundColor(.petid_gray)
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
                        .stroke(gender == selectedGender ? Color.petid_clearblue : Color.petid_d9, lineWidth: 1)
                )
                .foregroundColor(gender == selectedGender ? Color.petid_clearblue : Color.petid_d9)
                .font(gender == selectedGender ? .system(size: 15, weight: .bold) : .system(size: 15))
        }
    }
}

