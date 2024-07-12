import SwiftUI

struct UserAServiceTermsRequest {
    let term: UserServiceTerms
    let isAgreed: Bool = false
}

final class TermsAgreementViewModel: BaseViewModel {
    @Published var terms: [UserAServiceTermsRequest]
    
    override init() {
        terms = UserServiceTerms.allCases
            .map {
                return UserAServiceTermsRequest(
                    term: $0
                )
            }
    }
}

struct TermsAgreementView: View {
    
    @ObservedObject var viewModel: TermsAgreementViewModel
    @State private var agreeTerms = false
    @State private var agreePrivacy = false
    @State private var agreeMarketing = false
    @State private var showUserInfo = false
    
    init(viewModel: TermsAgreementViewModel = TermsAgreementViewModel()) {
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
            }
            .padding(.horizontal, 26)
        }
    }
    
    var navigationBar: some View {
        HStack {
            Button(action: {
                
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
        VStack {
            HStack {
//                CheckBox(isChecked: Binding(get: {}, set: <#T##(Value) -> Void#>))
                Text("약관 전체 동의")
            }
        }
    }
}

#Preview {
    TermsAgreementView()
}
