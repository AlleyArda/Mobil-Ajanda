// App/Auth/ViewModel/AuthViewModel.swift
import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    func signIn(email: String, password: String) {
        // AuthService kullanarak kullanıcıyı doğruluyoruz
        if let user = AuthService.shared.authenticate(email: email, password: password) {
            currentUser = user
            isAuthenticated = true
            print("User authenticated: \(user)")
        } else {
            isAuthenticated = false
            print("Authentication failed for email: \(email)")
        }
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
        print("User signed out")
    }
}
