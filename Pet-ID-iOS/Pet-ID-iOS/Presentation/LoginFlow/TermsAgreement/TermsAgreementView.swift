import SwiftUI

struct UserServiceTermsRequest: Identifiable {
    let id: String = UUID().uuidString
    let term: UserServiceTerms
    var isAgreed: Bool = false
}

struct TermsAgreementView: View {
    
    @ObservedObject var viewModel: TermsAgreementViewModel
    
    var allAgreed: Bool {
        return viewModel.terms.allSatisfy { $0.isAgreed }
    }
    
    var isNextalble: Bool {
        return viewModel.terms.filter {
            $0.term.agreementType == .required
        }.allSatisfy { $0.isAgreed }
    }
    
    init(viewModel: TermsAgreementViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                navigationBar
                
                Spacer()
                    .frame(maxHeight: 33)
                
                title
                    .padding(.leading, 10)
                
                Spacer()
                
                temsAgreementView
                
                Spacer()
                
                nextButton
            }
            .padding(.horizontal, 26)
        }
    }
    
    var navigationBar: some View {
        HStack {
            Button(action: {
                viewModel.handleBackBtnTap()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
            Spacer()
        }
    }
    
    var title: some View {
        VStack {
            HStack {
                Text("펫아이디 서비스")
                    .font(.title3)
                    .padding(.top, 20)
                Spacer()
            }
            
            HStack {
                Text("이용 약관에 동의")
                    .foregroundColor(.blue)
                + Text("해 주세요.")
                
                Spacer()
            }
        }
    }
    
    var temsAgreementView: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack {
                CheckBox(
                    isChecked:
                        Binding(
                            get: {
                                allAgreed
                            },
                            set:  { _ in }
                        )
                )
                .disabled(true)
                
                Text("약관 전체 동의")
                
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    viewModel.handleAllAgreeTap(allAgreed)
                }
            }
            
            Spacer()
                .frame(height: 19.5)
            
            Divider()
            
            Spacer()
                .frame(height: 21.5)
            
            VStack(spacing: 28) {
                ForEach(viewModel.terms.indices, id: \.self) { index in
                    HStack(alignment: .top) {
                        HStack {
                            CheckBox(isChecked: $viewModel.terms[index].isAgreed)
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.terms[index].term.title)
                                
                                let subtitle = viewModel.terms[index].term.subTitle
                                if !subtitle.isEmpty {
                                    Text(subtitle)
                                }
                            }
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                viewModel.terms[index].isAgreed.toggle()
                            }
                        }
                        
                        Image(systemName: "chevron.right")
                            .onTapGesture {
                                 _ = print("adfasdf")
                            }
                    }
                }
            }
        }
    }
    
    var nextButton: some View {
        IsEnablePetButton(
            title: "확인",
            isEnabled: .constant(isNextalble),
            action: {
                viewModel.handleJoinBtnTap()
            }
        )
        .frame(height: 56)
    }
}

#Preview {
    TermsAgreementView(viewModel: .init(oauth: OAuth(type: .apple, accessToken: "", id: "")))
}
