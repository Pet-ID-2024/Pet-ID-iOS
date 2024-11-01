import SwiftUI

struct InputField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.body4_med)
                .foregroundColor(.petid_gray)
            
            HStack {
                TextField("", text: $text)
                    .font(.body2_med)
                    .foregroundColor(.petid_title)
                
                
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.petid_d9)
                    }
                
            }
            Divider()
                .background(Color.petid_d9)
        }
    }
}



