//
//  NameField.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/1/24.
//

import SwiftUI

struct CustomField: View {
    @Binding var text: String
    var field: PetInfoViewModel.Field
    var placeholder: String
    var label: String
    var inputType: InputType
    
    @State private var showDatePickerSheet: Bool = false
    @State private var selectedDate: Date = Date()
    
    enum InputType {
        case text
        case date
        case phoneNumber
        case address
        case detailAddress
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .padding(.bottom, 4)
            
            switch inputType {
            case .date:
                DatePickerField(
                    text: $text,
                    showDatePickerSheet: $showDatePickerSheet,
                    selectedDate: $selectedDate,
                    field: field,
                    placeholder: placeholder
                )
            case .phoneNumber:
                PhoneNumberField(
                    text: $text,
                    placeholder: placeholder,
                    field: field
                )
            case .address:
                AddressField(
                    text: $text,
                    placeholder: placeholder,
                    field: field
                )
            case .detailAddress:
                DetailAddressField(text: $text,
                                   placeholder: placeholder, field: field)
            case .text:
                TextFieldView(
                    text: $text,
                    placeholder: placeholder,
                    field: field
                )
            }
        }
        .sheet(isPresented: $showDatePickerSheet) {
            DatePickerSheet(
                selectedDate: $selectedDate,
                onDone: {
                    text = DateFormatter.petInfoDateFormatter.string(from: selectedDate)
                    showDatePickerSheet = false
                }
            )
        }
    }
}

struct DatePickerField: View {
    @Binding var text: String
    @Binding var showDatePickerSheet: Bool
    @Binding var selectedDate: Date
    var field: PetInfoViewModel.Field
    var placeholder: String
    
    var body: some View {
        HStack {
            Text(text.isEmpty ? placeholder : text)
                .foregroundColor(text.isEmpty ? Color.gray : Color.black)
            Spacer()
            Image(systemName: "calendar")
                .foregroundColor(.gray)
                .onTapGesture {
                    showDatePickerSheet.toggle()
                }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct DetailAddressField: View {
    @Binding var text: String
    var placeholder: String
    var field: PetInfoViewModel.Field
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct PhoneNumberField: View {
    @Binding var text: String
    var placeholder: String
    var field: PetInfoViewModel.Field
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .keyboardType(.phonePad)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct AddressField: View {
    @Binding var text: String
    var placeholder: String
    var field: PetInfoViewModel.Field
    
    var body: some View {
        HStack {
            Text(text.isEmpty ? placeholder : text)
                .foregroundColor(text.isEmpty ? Color.gray : Color.black)
            Spacer()
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct TextFieldView: View {
    @Binding var text: String
    var placeholder: String
    var field: PetInfoViewModel.Field
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    var onDone: () -> Void
    
    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
            Button("Done", action: onDone)
                .padding()
        }
    }
}

