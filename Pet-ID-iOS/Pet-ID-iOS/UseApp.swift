import SwiftUI

struct UseApp: View {
    @State private var agreeAll = false
    @State private var agreeTerms = false
    @State private var agreePrivacy = false
    @State private var agreeMarketing = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showUserInfo = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // 뒤로 가기 버튼
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                
                // 서비스 제목과 설명
                VStack(alignment: .leading) {
                    Text("펫아이디 서비스")
                        .font(.title)
                    
                    HStack(spacing: 0) {
                        Text("이용 약관에 동의")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("해 주세요.")
                            .font(.title)
                    }
                }
                .padding()
                
                Spacer()
                
                // 전체 동의 토글
                Toggle(isOn: Binding(
                    get: { self.agreeAll },
                    set: { newValue in
                        self.agreeAll = newValue
                        self.setAllAgreeState(to: newValue)
                    }
                )) {
                    Text("약관 전체동의")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding()
                
                Divider()
                
                // 개별 동의 항목
                VStack(alignment: .leading, spacing: 10) {
                    Toggle(isOn: Binding(
                        get: { self.agreeTerms },
                        set: { newValue in
                            self.agreeTerms = newValue
                            self.checkIfAllAgreed()
                        }
                    )) {
                        HStack {
                            Text("이용약관(필수)")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.horizontal)
                    
                    Toggle(isOn: Binding(
                        get: { self.agreePrivacy },
                        set: { newValue in
                            self.agreePrivacy = newValue
                            self.checkIfAllAgreed()
                        }
                    )) {
                        HStack {
                            Text("개인정보 수집 및 이용동의(필수)")
                            Spacer()
                            NavigationLink(destination: PrivacyPolicyView()) {
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.horizontal)
                    
                    Toggle(isOn: Binding(
                        get: { self.agreeMarketing },
                        set: { newValue in
                            self.agreeMarketing = newValue
                            self.checkIfAllAgreed()
                        }
                    )) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("E-mail 및 SMS 광고성 정보 수신동의(선택)")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            Text("다양한 혜택과 신규 소식을 보내드립니다.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // 다음 버튼
                Button(action: {
                    showUserInfo = true
                }) {
                    NavigationLink(destination: UserInfo(), isActive: $showUserInfo) {
                        Text("다음")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(agreeTerms && agreePrivacy ? Color.blue : Color.gray)
                            .cornerRadius(10)
                            .padding()
                    }
                }
                .disabled(!(agreeTerms && agreePrivacy))
            }
            .navigationBarBackButtonHidden()
        }
    }

    // 모든 동의 상태를 설정하는 함수
    private func setAllAgreeState(to state: Bool) {
        agreeTerms = state
        agreePrivacy = state
        agreeMarketing = state
    }

    // 모든 개별 동의 항목이 동의되었는지 확인하는 함수
    private func checkIfAllAgreed() {
        agreeAll = agreeTerms && agreePrivacy && agreeMarketing
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                configuration.label
            }
        }
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        Text("개인정보 처리방침 내용")
            .navigationBarTitle("개인정보 처리방침", displayMode: .inline)
    }
}

struct UseApp_Previews: PreviewProvider {
    static var previews: some View {
        UseApp()
    }
}
