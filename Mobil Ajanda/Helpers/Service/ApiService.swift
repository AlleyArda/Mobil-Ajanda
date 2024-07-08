// App/Helpers/Service/ApiService.swift
import Foundation

class AuthService {
    static let shared = AuthService()
    
    private var users: [User] = []
    
    private init() {
        loadUsers()
    }
    
    private func loadUsers() {
        // `mockUsersJSON` değişkeninden kullanıcı verilerini yüklüyoruz
        let data = Data(mockUsersJSON.utf8)
        let decoder = JSONDecoder()
        
        do {
            let usersData = try decoder.decode([String: [User]].self, from: data)
            if let users = usersData["users"] {
                self.users = users
                print("Users loaded: \(users)")
            }
        } catch {
            print("Error loading users: \(error)")
        }
    }
    
    func authenticate(email: String, password: String) -> User? {
        // Kullanıcıyı email ve şifreye göre doğruluyoruz
        let user = users.first { $0.email == email && $0.password == password }
        if let user = user {
            print("Authentication successful for user: \(user)")
        } else {
            print("Authentication failed for email: \(email)")
        }
        return user
    }
}
