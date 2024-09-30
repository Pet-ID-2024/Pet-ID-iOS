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
                
                
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.petid_foregray)
                    }
                
            }
            Divider()
                .background(Color.gray)
        }
    }
}

