//
//  AuthView.swift
//  Mobil Ajanda
//
//  Created by Fatih Durmaz on 8.07.2024.
//

import SwiftUI
import AlertToast

struct AuthView: View {
    @State var viewModel = AuthViewModel()
    @State private var showProgressView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ProgressView()
                //Header
                ZStack {
                    HeaderView(title: "Hoşgeldiniz", subTitle: "Mobil Ajanda", angle: 15, background: .blue)
                }
                
                // Login Form
                Form {
                    HStack {
                        Image(systemName: "mail")
                        TextField("E-Posta", text: $viewModel.email)
                            .autocapitalization(.none)
                    }
                    
                    HStack {
                        Image(systemName: "lock")
                        SecureFieldView(password: viewModel.password, placeHolder: "Şifre")

                    }
                    
                    LoginButton(title: "Giriş Yap", background: .blue, action: {
                        viewModel.login()
                    })
                    .padding()
                }
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .offset(y:-75)
                
                
                
                VStack{
                    Text("TEDAŞ Bilgi Teknolojileri")
                        .bold()
                        .font(.title2)
                    
                    Button("Şifremi Unuttum"){
                        
                    }
                    .font(.callout)
                    
                    
                }
                .offset(y:-50)
                
                
            }
            .ignoresSafeArea()
            
            if showProgressView {
                ProgressView() // İlerleme göstergesini göster
            }
        }
        .toast(isPresenting: $viewModel.showError) {
            AlertToast(displayMode:.alert, type: .error(.orange), title: "Uyarı", subTitle: viewModel.errorMessage)
        }
        
    }
}

#Preview {
    AuthView()
}
