//
//  SecureFieldView.swift
//  Mobil Ajanda
//
//  Created by Fatih Durmaz on 8.07.2024.
//

import SwiftUI

struct SecureFieldView: View {
    @State var password: String
    let placeHolder : String
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        ZStack(alignment:.trailing) {
            if isPasswordVisible {
                TextField(placeHolder, text: $password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding(.trailing, 30)
                
            } else {
                SecureField(placeHolder , text: $password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding(.trailing, 30)
            }
            
            Button(action: {
                withAnimation() {
                    isPasswordVisible.toggle()
                }
            }) {
                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                    .foregroundStyle(.gray)
            }
            
        }
        .padding(10)
        .overlay{
            RoundedRectangle(cornerRadius: 8).stroke(.gray)
        }
    }
}

#Preview {
    SecureFieldView(password: "123456", placeHolder: "Şifre")
}
