import SwiftUI
//jul 9 15.06
struct SecureFieldView: View {
    @Binding var password: String
    var placeHolder: String
    var icon: Image
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack {
            icon
                .frame(width: 40, height: 40)


            
            if isPasswordVisible {
                TextField(placeHolder, text: $password)
                    .textContentType(.password)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .disableAutocorrection(true)
                    .padding(.trailing, 30)
            } else {
                SecureField(placeHolder, text: $password)
                    .textContentType(.password)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .disableAutocorrection(true)
                    .padding(.trailing, 30)
            }
            
            Button(action: {
                withAnimation {
                    isPasswordVisible.toggle()
                }
            }) {
                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 10)
        }
        //.padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 8).stroke(Color.gray)
        }
    }
}

#Preview {
    SecureFieldView(password: .constant("1234"), placeHolder: "Şifre", icon: Image(systemName: "lock"))
    
}
