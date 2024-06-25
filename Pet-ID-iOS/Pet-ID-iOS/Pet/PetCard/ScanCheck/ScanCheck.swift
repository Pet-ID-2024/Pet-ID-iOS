import SwiftUI

struct ScanCheck: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var productType: String = ""
    @State private var furColor: String = ""
    @State private var furFeatures: String = ""
    @State private var bodyWeight: String = ""
    @State private var navigateToInformationCheck = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                
                Text("스캔된 정보를 확인해주세요.")
                    .font(.system(size: 24))
                    .padding(.top)
                
                Text("스캔 정보가 틀렸을 경우 직접 수정할 수 있어요.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 10) {
                    ForEach(0..<3) { _ in
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
                .padding(.vertical)
                
                Group {
                    Text("품종")
                    ZStack(alignment: .trailing) {
                        TextField("품종을 입력해주세요.", text: $productType)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        
                        if !productType.isEmpty {
                            Button(action: {
                                productType = ""
                            }) {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                }
                
                Group {
                    Text("털 색깔")
                    ZStack(alignment: .trailing) {
                        TextField("털 색깔을 입력해주세요.", text: $furColor)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        
                        if !furColor.isEmpty {
                            Button(action: {
                                furColor = ""
                            }) {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                }
                
                Group {
                    Text("털 특징")
                    ZStack(alignment: .trailing) {
                        TextField("털 특징을 입력해주세요.", text: $furFeatures)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        
                        if !furFeatures.isEmpty {
                            Button(action: {
                                furFeatures = ""
                            }) {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                }
                
                Group {
                    Text("몸무게")
                    ZStack(alignment: .trailing) {
                        TextField("몸무게를 입력해주세요.", text: $bodyWeight)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        
                        if !bodyWeight.isEmpty {
                            Button(action: {
                                bodyWeight = ""
                            }) {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: InformationCheck().navigationBarHidden(true), isActive: $navigateToInformationCheck) {
                    Text("다음")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            
        }
        
    }
}

struct ScanCheck_Previews: PreviewProvider {
    static var previews: some View {
        ScanCheck()
    }
}
