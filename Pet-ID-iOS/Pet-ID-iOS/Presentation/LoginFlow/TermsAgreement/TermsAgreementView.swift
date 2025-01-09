//import SwiftUI
//
//struct UserServiceTermsRequest: Identifiable {
//    let id: String = UUID().uuidString
//    let term: UserServiceTerms
//    var isAgreed: Bool = false
//}
//
//struct TermsAgreementView: View {
//    
//    @ObservedObject var viewModel: TermsAgreementViewModel
//    
//    var allAgreed: Bool {
//        return viewModel.terms.allSatisfy { $0.isAgreed }
//    }
//    
//    var isNextalble: Bool {
//        return viewModel.terms.filter {
//            $0.term.agreementType == .required
//        }.allSatisfy { $0.isAgreed }
//    }
//    
//    init(viewModel: TermsAgreementViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        ZStack {
//            VStack {
////                navigationBar
//                
//                Spacer()
//                    .frame(maxHeight: 33)
//                
//                title
//                    .padding(.leading, 10)
//                
//                Spacer()
//                
//                temsAgreementView
//                
//                Spacer()
//                
//                nextButton
//            }
//            .padding(.horizontal, 26)
//        }
//    }
//    
////    var navigationBar: some View {
////        HStack {
////            Button(action: {
////                viewModel.handleBackBtnTap()
////            }) {
////                Image(systemName: "chevron.left")
////                    .foregroundColor(.black)
////            }
////            Spacer()
////        }
////    }
//    
//    var title: some View {
//        VStack {
//            HStack {
//                Text("펫아이디 서비스")
//                    .font(.headline1)
//                    .padding(.top, 20)
//                Spacer()
//            }
//            
//            HStack {
//                Text("이용 약관에 동의")
//                    .foregroundColor(.petid_clearblue)
//                + Text("해 주세요.")
//                
//                Spacer()
//            }
//            .font(.headline1)
//        }
//    }
//    
//    var temsAgreementView: some View {
//        VStack(alignment: .leading, spacing: 0){
//            HStack {
//                CheckBox(
//                    isChecked:
//                        Binding(
//                            get: {
//                                allAgreed
//                            },
//                            set:  { _ in }
//                        )
//                )
//                .disabled(true)
//                
//                Text("약관 전체 동의")
//                
//                Spacer()
//            }
//            .contentShape(Rectangle())
//            .onTapGesture {
//                withAnimation {
//                    viewModel.handleAllAgreeTap(allAgreed)
//                }
//            }
//            
//            Spacer()
//                .frame(height: 19.5)
//            
//            Divider()
//            
//            Spacer()
//                .frame(height: 21.5)
//            
//            VStack(spacing: 28) {
//                ForEach(viewModel.terms.indices, id: \.self) { index in
//                    HStack(alignment: .top) {
//                        HStack {
//                            CheckBox(isChecked: $viewModel.terms[index].isAgreed)
//                            
//                            VStack(alignment: .leading) {
//                                Text(viewModel.terms[index].term.title)
//                                
//                                let subtitle = viewModel.terms[index].term.subTitle
//                                if !subtitle.isEmpty {
//                                    Text(subtitle)
//                                }
//                            }
//                            Spacer()
//                        }
//                        .contentShape(Rectangle())
//                        .onTapGesture {
//                            withAnimation {
//                                viewModel.terms[index].isAgreed.toggle()
//                            }
//                        }
//                        
//                        Image(systemName: "chevron.right")
//                            .onTapGesture {
//                                 _ = print("adfasdf")
//                            }
//                    }
//                }
//            }
//        }
//    }
//    
//    var nextButton: some View {
//        IsEnablePetButton(
//            title: "확인",
//            isEnabled: .constant(isNextalble),
//            action: {
//                viewModel.handleJoinBtnTap()
//            }
//        )
//        .frame(height: 56)
//    }
//}
//
//#Preview {
//    TermsAgreementView(viewModel: .init(oauth: OAuth(type: .apple, accessToken: "", id: "")))
//}

import SwiftUI

struct UserServiceTermsRequest: Identifiable {
    let id: String = UUID().uuidString
    let term: UserServiceTerms
    var isAgreed: Bool = false
}

struct TermsAgreementView: View {
    
    @ObservedObject var viewModel: TermsAgreementViewModel
    
    /// 모든 약관에 동의했는지 확인
    var allAgreed: Bool {
        return viewModel.terms.allSatisfy { $0.isAgreed }
    }
    
    /// 필수 약관이 모두 동의되었는지 확인
    var isNextable: Bool {
        return viewModel.areRequiredTermsAgreed
    }
    
    var body: some View {
        VStack {
            title
                .padding(.top, 20)
                .padding(.leading, 10)
            
            Spacer()
            
            termsAgreementView
            
            Spacer()
            
            nextButton
        }
        .padding(.horizontal, 26)
    }
    
    /// 상단 제목
    var title: some View {
        VStack(alignment: .leading) {
            Text("펫아이디 서비스")
                .font(.headline1)
            
            Text("이용 약관에 동의")
                .foregroundColor(.petid_clearblue)
            + Text("해 주세요.")
        }
        .font(.headline1)
    }
    
    /// 약관 동의 리스트
    var termsAgreementView: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 전체 동의
            HStack {
                CheckBox(
                    isChecked:
                        Binding(
                            get: { allAgreed },
                            set: { _ in }
                        )
                )
                .disabled(true)
                
                Text("약관 전체 동의")
                
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    viewModel.handleAllAgreeTap(!allAgreed)
                }
            }
            
            Spacer().frame(height: 19.5)
            
            Divider()
            
            Spacer().frame(height: 21.5)
            
            // 개별 약관 동의
            VStack(spacing: 28) {
                ForEach(viewModel.terms.indices, id: \.self) { index in
                    HStack(alignment: .top) {
                        CheckBox(isChecked: $viewModel.terms[index].isAgreed)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.terms[index].term.title)
                            
                            let subtitle = viewModel.terms[index].term.subTitle
                            if !subtitle.isEmpty {
                                Text(subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
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
                }
            }
        }
    }
    
    /// 확인 버튼
    var nextButton: some View {
        IsEnablePetButton(
            title: "확인",
            isEnabled: .constant(isNextable),
            action: {
                viewModel.handleAgreeAndLoginTap()
            }
        )
        .frame(height: 56)
    }
}

#Preview {
    TermsAgreementView(viewModel: .init(oauth: OAuth(type: .apple, accessToken: "", id: "")))
}
