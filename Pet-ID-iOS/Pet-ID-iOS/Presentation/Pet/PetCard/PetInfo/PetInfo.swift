import SwiftUI

struct PetInfo: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var name: String = ""
    @State private var birthDate: String = ""
    @State private var showDatePicker: Bool = false
    @State private var selectedDate: Date = Date()
    @State private var gender: String = ""
    @State private var neutered: String = ""
    @State private var neuteringDate: String = ""
    @State private var address: String = ""
    @State private var detailAddress: String = ""
    @State private var isNextScreenPresented = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // 뒤로 가기 버튼
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding()
                        }
                        Spacer()
                    }

                    // 서비스 제목과 설명
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            Text("반려동물의 정보")
                                .font(.title)
                                .foregroundColor(.blue)
                            Text("를")
                                .font(.title)
                        }
                        Text("입력해주세요.")
                            .font(.title)
                    }
                    .padding()

                    Spacer()

                    VStack(alignment: .leading, spacing: 20) {
                        // 이름 입력 필드
                        Group {
                            Text("이름")
                            TextField("이름을 입력해 주세요.", text: $name)
                                .padding()
                                .cornerRadius(8)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                .onChange(of: name) { newValue in
                                    let filtered = newValue.filter { $0.isLetter }
                                    if filtered != newValue {
                                        self.name = filtered
                                    }
                                }
                        }

                        // 생년월일 입력 필드
                        Group {
                            Text("생년월일")
                            HStack {
                                TextField("생년월일 6자리", text: $birthDate)
                                    .padding()
                                    .cornerRadius(8)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    .keyboardType(.numberPad)
                                    .overlay(
                                       HStack {
                                           Spacer()
                                           Image(systemName: "calendar")
                                               .foregroundColor(.gray)
                                               .padding()
                                               .onTapGesture {
                                                   showDatePicker = true
                                               }
                                           }
                                       )
                            }
                        }

                        // 성별 선택 필드
                        Group {
                            Text("성별")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            HStack {
                                Button(action: {
                                    gender = "남"
                                }) {
                                    Text("남")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(gender == "남" ? Color.blue : Color.gray, lineWidth: 1)
                                        )
                                        .foregroundColor(gender == "남" ? .blue : .black)
                                }
                                
                                Button(action: {
                                    gender = "여"
                                }) {
                                    Text("여")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(gender == "여" ? Color.blue : Color.gray, lineWidth: 1)
                                        )
                                        .foregroundColor(gender == "여" ? .blue : .black)
                                }
                            }
                        }

                        // 중성화 여부 선택 필드
                        Group {
                            Text("중성화 여부")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            HStack {
                                Button(action: {
                                    neutered = "Y"
                                }) {
                                    Text("Y")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(neutered == "Y" ? Color.blue : Color.gray, lineWidth: 1)
                                        )
                                        .foregroundColor(neutered == "Y" ? .blue : .black)
                                }
                                
                                Button(action: {
                                    neutered = "N"
                                }) {
                                    Text("N")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(neutered == "N" ? Color.blue : Color.gray, lineWidth: 1)
                                        )
                                        .foregroundColor(neutered == "N" ? .blue : .black)
                                }
                            }
                        }


                        // 중성화 날짜 입력 필드
                        Group {
                            Text("중성화 날짜")
                            HStack {
                                TextField("중성화 날짜", text: $neuteringDate)
                                    .padding()
                                    .cornerRadius(8)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    .keyboardType(.numberPad)
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            Image(systemName: "calendar")
                                                .foregroundColor(.gray)
                                                .padding()
                                                .onTapGesture {
                                                    showDatePicker = true
                                                }
                                        }
                                    )
                            }
                        }
                        
                        Group {
                            Text("주소")
                            VStack {
                                TextField("주소를 입력해 주세요.", text: $address)
                                    .padding()
                                    .cornerRadius(8)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                
                                TextField("상세주소를 입력해 주세요.", text: $detailAddress)
                                    .padding()
                                    .cornerRadius(8)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                            }
                        }

                        // 완료 버튼
                        NavigationLink(destination: PetCaption(), isActive: $isNextScreenPresented) {
                            EmptyView()
                        }
                        .hidden()

                        Button(action: {
                            isNextScreenPresented = true
                        }) {
                            Text("완료")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()

                    Spacer()
                }
            }
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                    Button("Done") {
                        birthDate = dateFormatter.string(from: selectedDate)
                        showDatePicker = false
                    }
                    .padding()
                    
                }
            }
            .navigationBarBackButtonHidden(true) // 네비게이션 바의 뒤로 가기 버튼 숨기기
        }
    }
}

struct PetInfo_Previews: PreviewProvider {
    static var previews: some View {
        PetInfo()
    }
}
