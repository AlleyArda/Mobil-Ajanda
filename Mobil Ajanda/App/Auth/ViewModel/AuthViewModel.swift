// App/Auth/ViewModel/AuthViewModel.swift
import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var shouldNavigate: Bool = false  // Bu değişkeni ekleyin

    private var cancellables = Set<AnyCancellable>()
    
    func signIn(email: String, password: String) {
        // AuthService kullanarak kullanıcıyı doğruluyoruz
        if let user = AuthService.shared.authenticate(email: email, password: password) {
            currentUser = user
            isAuthenticated = true
            shouldNavigate = true  // Yönlendirme durumunu ayarlayın
            print("User authenticated: \(user)")
        } else {
            isAuthenticated = false
            shouldNavigate = false  // Yönlendirme durumunu sıfırlayın
            print("Authentication failed for email: \(email)")
        }
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
        shouldNavigate = false  // Yönlendirme durumunu sıfırlayın
        print("User signed out")
    }
}
