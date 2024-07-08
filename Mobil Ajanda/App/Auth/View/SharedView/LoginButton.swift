//
//  LoginButton.swift
//  Mobil Ajanda
//
//  Created by Fatih Durmaz on 8.07.2024.
//

import SwiftUI

struct LoginButton: View {
    let title : String
    let background : Color
    let action : () -> Void

    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(background)
                Text(title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(10)
            }
        }
    }
}

#Preview {
    LoginButton(title: "Giriş Yap", background: .blue){
        
    }
}
