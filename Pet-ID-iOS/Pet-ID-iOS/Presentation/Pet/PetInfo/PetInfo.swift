import SwiftUI

struct PetInfo: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = PetInfoViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
                    .padding(.top, -10)
                    .padding(.leading, -10)
                    
                    
                    VStack(alignment: .leading) {
                        Text("3/7")
                        Text("반려동물의 정보를 \n알려주세요")
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        CustomField(
                            text: $viewModel.name,
                            field: .name,
                            placeholder: "이름",
                            label: "반려동물이름",
                            inputType: .text
                        )
                        
                        
                        
                        CustomField(
                            text: $viewModel.birthDate,
                            field: .birthDate,
                            placeholder: "생년월일 선택",
                            label: "생년월일",
                            inputType: .date
                        )
                        
                        
                        GenderField(
                            gender: $viewModel.gender,
                            focusedField: $viewModel.focusedField
                        )
                        
                        
                        CustomField(
                            text: $viewModel.neuteringDate,
                            field: .neuteringDate,
                            placeholder: "중성화 날짜 선택",
                            label: "중성화 날짜",
                            inputType: .date
                        )
                        
                        
                        VStack {
                            HStack {
                                CheckBox(isChecked: $viewModel.neuteredChecked)
                                Text("중성화 전이에요.")
                            }
                        }
                        
                        
                        NavigationLink(destination: PetCaption(viewModel: PetCaptionViewModel(), coordinator: PetCaptionCoordinator(navigationController: UINavigationController())), isActive: $viewModel.isNextScreenPresented) {
                            EmptyView()
                        }
                        .hidden()
                        
                        Button(action: {
                            viewModel.isNextScreenPresented = true
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
            .sheet(isPresented: $viewModel.showDatePicker) {
                VStack {
                    DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                    Button("Done") {
                        if viewModel.focusedField == .birthDate {
                            viewModel.updateBirthDate(with: viewModel.selectedDate)
                        } else if viewModel.focusedField == .neuteringDate {
                            viewModel.updateNeuteringDate(with: viewModel.selectedDate)
                        }
                        viewModel.showDatePicker = false
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .padding()
    }
}

#Preview {
    PetInfo()
}
