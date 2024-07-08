// App/Auth/View/LoginView.swift
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    print("Sign In button tapped with email: \(email) and password: \(password)")
                    viewModel.signIn(email: email, password: password)
                }) {
                    Text("Sign In")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                // NavigationLink to navigate to the appropriate view after login
                NavigationLink(
                    destination: destinationView,
                    isActive: $viewModel.shouldNavigate,
                    label: {
                        EmptyView()
                    }
                )
            }
            .navigationTitle("Login")
        }
    }
    
    // Determine the destination view based on user role
    @ViewBuilder
    var destinationView: some View {
        if let user = viewModel.currentUser {
            switch user.role {
            case .manager:
                MainView(currentUser: user)
            case .driver:
                DriverView(currentUser: user)
            case .securityChief:
                MainView(currentUser: user) // Şimdilik manager gibi görsün
            }
        } else {
            LoginView()
        }
    }
}
