import SwiftUI

struct PetInfo: View {
    @StateObject private var viewModel = PetInfoViewModel()
    var coordinator: PetInfoCoordinator
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            viewModel.navigateBack()
                        }) {
                            DSImage.chevronicon.toImage()
                                .font(.petIdChevron)
                                .foregroundColor(.black)
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("3/7")
                            .font(.petIdTitle1)
                            .foregroundColor(.petid_clearblue)
                        Text("반려동물의 정보를 \n알려주세요")
                            .font(.petIdTitle1)
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 25) {
                        
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
                        
                        VStack(alignment: .leading, spacing: 20){
                        CustomField(
                            text: $viewModel.neuteringDate,
                            field: .neuteringDate,
                            placeholder: "중성화 날짜 선택",
                            label: "중성화 날짜",
                            inputType: .date
                        )
                        
                        
                        
                            HStack {
                                CheckBox(isChecked: $viewModel.neuteredChecked)
                                Text("중성화 전이에요.")
                                    .font(.petIdBody1)
                                    .fontWeight(.medium)
                                    .foregroundColor(.petid_foregray)
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
                                .background(Color.petid_clearblue)
                                .foregroundColor(.petid_white)
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
    PetInfo(coordinator: PetInfoCoordinator(navigationController: UINavigationController()))
}
