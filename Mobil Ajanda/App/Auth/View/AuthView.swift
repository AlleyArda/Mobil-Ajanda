import SwiftUI
import AlertToast

struct AuthView: View {
    @State var viewModel = AuthViewModel()
    @State private var showProgressView = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                
                VStack {
                    //Header
                    HeaderView(title: "Hoşgeldiniz", subTitle: "Mobil Ajanda", background: .blue)
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                    
                    // Login Form
                    VStack {
                        
                        
                        TextFieldView(text: $viewModel.email, placeHolder: "E-Posta", icon: Image(systemName: "mail"))
                            .padding(.bottom, 10)
                        
                        
                        SecureFieldView(password:$viewModel.password, placeHolder: "Şifre", icon: Image(systemName: "lock")
                        )
                        .padding(.bottom, 10)
                        
                        LoginButton(title: "Giriş Yap", background: .blue, action: {
                            showProgressView = true
                            Task{
                                await viewModel.login()
                                try await Task.sleep(nanoseconds: 1_000_000_000)
                                showProgressView = false
                            }
                        })
                        .frame(height: 50)
                        
                        
                        
                    }
                    .padding()
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    
                    
                    // Footer
                    VStack{
                        Divider()
                        
                        Text("TEDAŞ Bilgi Teknolojileri")
                            .bold()
                            .font(.title2)
                        
                        Button("Şifremi Unuttum"){
                            
                        }
                        .font(.callout)
                        
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.2)
                    
                    
                    
                }
                .ignoresSafeArea()
                
                if showProgressView {
                    ProgressView() // İlerleme göstergesini göster
                        .frame(width: 50, height: 50)
                        .background(.gray.gradient)
                        .clipShape(.circle)
                        .shadow(radius: 10)
                        .tint(.white)
                    
                    
                }
                
            }
            
            
        }
        .toast(isPresenting: $viewModel.showError) {
            AlertToast(displayMode:.alert, type: .error(.red), title: "Uyarı", subTitle: viewModel.errorMessage)
        }
    }
}

#Preview {
    AuthView()
}
