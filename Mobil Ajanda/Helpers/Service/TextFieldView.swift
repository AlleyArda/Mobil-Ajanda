import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    var placeHolder: String
    var icon: Image
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack {
            icon
                .frame(width: 40, height: 40)

            TextField(placeHolder, text: $text)
                .textContentType(.emailAddress)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(true)
                .autocorrectionDisabled()
            
        }
        //.padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 8).stroke(Color.gray)
        }
    }
}

#Preview {
    TextFieldView(text: .constant("arda@gmail.com"), placeHolder: "E-Posta", icon: Image(systemName: "mail"))
    
}

