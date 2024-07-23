import SwiftUI
import AlertToast

struct AuthView: View {
    @State var viewModel = AuthViewModel()
    @State private var showProgressView = false
    @State private var navigateToRootView = false
    @FocusState private var focusedField: Field?
    @AppStorage("isOn") var isOn = false
    @AppStorage("isOnHaptic") var isOnHaptic = true
    enum Field {
        case email
        case password
    }
    
    
    
    
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
                            .focused($focusedField, equals: .email)
                            .submitLabel(.next)
                            .toolbar {
                                
                                ToolbarItemGroup(placement: .keyboard) {
                                    if focusedField == .email {
                                        Button("Done") {
                                            focusedField = nil
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: { focusedField = .password }, label: {
                                            Image(systemName: "chevron.down")
                                        })
                                        .padding()
                                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                            Image(systemName: "chevron.up")
                                        })
                                    }
                                    
                                }
                            }
                        
                        SecureFieldView(password: $viewModel.password, placeHolder: "Şifre", icon: Image(systemName: "lock"))
                            .padding(.bottom, 10)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                            .toolbar {
                                
                                ToolbarItemGroup(placement: .keyboard) {
                                    if focusedField == .password {
                                        Button("Done") {
                                            focusedField = nil
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {}, label: {
                                            Image(systemName: "chevron.down")
                                        })
                                        .padding()
                                        Button(action: { focusedField = .email}, label: {
                                            Image(systemName: "chevron.up")
                                        })
                                    }
                                    
                                }
                            }
                        
                        HStack {
                            Button(action: {
                                login()
                            }) {
                                Text("Giriş Yap")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        .padding()
                                Toggle(
                                    "Beni Hatırla",
                                    systemImage: isOn ? "checkmark.square.fill" : "checkmark.square",
                                    isOn: $isOn).toggleStyle(.button)
                        }//HStack
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
                            // Handle forgot password action
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
        .onAppear {
            focusedField = nil
        }
    }
    
    private func login() {
        focusedField = nil
        showProgressView = true
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
            showProgressView = false
            await viewModel.login()
        }
    }
}

#Preview {
    AuthView()
}
