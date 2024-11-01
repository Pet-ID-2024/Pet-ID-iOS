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
    var label: String?
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
            Text(label!)
                .font(.body4_med)
//                .fontWeight(.medium)
                .foregroundColor(.petid_gray)
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
                .foregroundColor(text.isEmpty ? .petid_b4 : .petid_title)
            Spacer()
            Image(systemName: "calendar")
                .foregroundColor(.petid_title)
                .onTapGesture {
                    showDatePickerSheet.toggle()
                }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.petid_d9, lineWidth: 1)
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
                    .stroke(Color.petid_d9, lineWidth: 1)
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
                    .stroke(Color.petid_d9, lineWidth: 1)
            )
    }
}

struct AddressField: View {
    @Binding var text: String
    var placeholder: String
    var field: PetInfoViewModel.Field
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .foregroundColor(text.isEmpty ? .petid_b4 : .petid_title)
            Spacer()
            Image(systemName: "magnifyingglass")
                .foregroundColor(.petid_title)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.petid_d9, lineWidth: 1)
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
                    .stroke(Color.petid_d9, lineWidth: 1)
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

// 리팩토링
//
//  CustomField.swift
//  Pet-ID-iOS
//
//  Created by 박호건 on 8/1/24.
//

//import SwiftUI
//
//struct CustomField: View {
//    @Binding var text: String
//    var field: PetInfoViewModel.Field
//    var placeholder: String
//    var label: String = "" // 기본값을 빈 문자열로 설정하여 옵셔널 처리 불필요
//
//    var inputType: InputType
//
//    @State private var showDatePickerSheet: Bool = false
//    @State private var selectedDate: Date = Date()
//
//    enum InputType {
//        case text
//        case date
//        case phoneNumber
//        case address
//        case detailAddress
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // 레이블이 비어있지 않을 경우에만 표시
//            if !label.isEmpty {
//                Text(label)
//                    .font(.body4_med)
//                    .foregroundColor(.petid_gray)
//                    .padding(.bottom, 4)
//            }
//
//            switch inputType {
//            case .date:
//                DatePickerField(
//                    text: $text,
//                    showDatePickerSheet: $showDatePickerSheet,
//                    selectedDate: $selectedDate,
//                    placeholder: placeholder
//                )
//            case .phoneNumber:
//                PhoneNumberField(
//                    text: $text,
//                    placeholder: placeholder
//                )
//            case .address:
//                AddressField(
//                    text: $text,
//                    placeholder: placeholder
//                )
//            case .detailAddress:
//                DetailAddressField(
//                    text: $text,
//                    placeholder: placeholder
//                )
//            case .text:
//                TextFieldView(
//                    text: $text,
//                    placeholder: placeholder
//                )
//            }
//        }
//        // 날짜 선택 시트를 표시하기 위한 시트 모디파이어
//        .sheet(isPresented: $showDatePickerSheet) {
//            DatePickerSheet(
//                selectedDate: $selectedDate,
//                onDone: {
//                    text = DateFormatter.petInfoDateFormatter.string(from: selectedDate)
//                    showDatePickerSheet = false
//                }
//            )
//        }
//    }
//}
//
//struct DatePickerField: View {
//    @Binding var text: String
//    @Binding var showDatePickerSheet: Bool
//    @Binding var selectedDate: Date
//    var placeholder: String
//
//    var body: some View {
//        HStack {
//            Text(text.isEmpty ? placeholder : text)
//                .foregroundColor(text.isEmpty ? .petid_b4 : .petid_title)
//            Spacer()
//            Image(systemName: "calendar")
//                .foregroundColor(.petid_title)
//                .onTapGesture {
//                    showDatePickerSheet.toggle()
//                }
//        }
//        .customFieldStyle()
//        .onTapGesture {
//            showDatePickerSheet.toggle()
//        }
//    }
//}
//
//struct DetailAddressField: View {
//    @Binding var text: String
//    var placeholder: String
//
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .customFieldStyle()
//    }
//}
//
//struct PhoneNumberField: View {
//    @Binding var text: String
//    var placeholder: String
//
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .keyboardType(.phonePad)
//            .customFieldStyle()
//    }
//}
//
//struct AddressField: View {
//    @Binding var text: String
//    var placeholder: String
//
//    var body: some View {
//        HStack {
//            TextField(placeholder, text: $text)
//                .foregroundColor(text.isEmpty ? .petid_b4 : .petid_title)
//            Spacer()
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(.petid_title)
//        }
//        .customFieldStyle()
//    }
//}
//
//struct TextFieldView: View {
//    @Binding var text: String
//    var placeholder: String
//
//    var body: some View {
//        TextField(placeholder, text: $text)
//            .customFieldStyle()
//    }
//}
//
//struct DatePickerSheet: View {
//    @Binding var selectedDate: Date
//    var onDone: () -> Void
//
//    var body: some View {
//        VStack {
//            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
//                .datePickerStyle(GraphicalDatePickerStyle())
//                .labelsHidden()
//            Button("완료", action: onDone)
//                .padding()
//        }
//    }
//}
//
//extension View {
//    func customFieldStyle() -> some View {
//        self
//            .padding()
//            .background(Color.white)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.petid_d9, lineWidth: 1)
//            )
//    }
//}
