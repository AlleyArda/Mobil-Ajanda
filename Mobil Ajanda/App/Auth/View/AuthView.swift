import SwiftUI
import AlertToast

struct AuthView: View {
    @State var viewModel = AuthViewModel()
    @State private var showProgressView = false
    @State private var navigateToRootView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Header
                    HeaderView(title: "Hoşgeldiniz", subTitle: "Mobil Ajanda", background: .blue)
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                    
                    // Login Form
                    VStack {
                        TextFieldView(text: $viewModel.email, placeHolder: "E-Posta", icon: Image(systemName: "mail"))
                            .padding(.bottom, 10)
                        
                        SecureFieldView(password: $viewModel.password, placeHolder: "Şifre", icon: Image(systemName: "lock"))
                            .padding(.bottom, 10)
                        
                        Button(action: {
                            showProgressView = true
                            Task {
                                try await Task.sleep(nanoseconds: 1_000_000_000) // 1 saniye bekle
                                showProgressView = false

                                await viewModel.login()

                            }
                        }) {
                            Text("Giriş Yap")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    
                    // Footer
                    VStack {
                        Divider()
                        
                        Text("TEDAŞ Bilgi Teknolojileri")
                            .bold()
                            .font(.title2)
                        
                        Button("Şifremi Unuttum") {
                            
                        }
                        .font(.callout)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.2)
                }
                .ignoresSafeArea()
                
                if showProgressView {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.7))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
            }
        }
        .toast(isPresenting: $viewModel.showError) {
            AlertToast(displayMode: .alert, type: .error(.red), title: "Uyarı", subTitle: viewModel.errorMessage)
        }
    }
}

#Preview {
    AuthView()
}
