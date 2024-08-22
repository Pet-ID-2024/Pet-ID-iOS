import SwiftUI

struct InputField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.petIdBody2)
                .foregroundColor(.petid_gray)
            
            HStack {
                TextField("", text: $text)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            Divider()
                .background(Color.gray)
        }
    }
}

