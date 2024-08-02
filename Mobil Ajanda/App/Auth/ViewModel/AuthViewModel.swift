import Foundation
import Observation
@Observable
class AuthViewModel {
    var email: String = "arda.kulaksiz@iedas.gov.tr"
    var password: String = "123456"
    var errorMessage: String = ""
    var showError: Bool = false
    var isAuthenticated: Bool = false
    var fullname: String = ""
    var currentUser: User?
    var currentRole: UserRole?
    private var users: [User] = []
    
    init() {
        loadUsers()
    }
    
    private func loadUsers() {
        do {
            let userData = try JSONDecoder().decode([String: [User]].self, from: mockUsersJSON)
            if let users = userData["users"] {
                self.users = users
            }
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    
    func login() async {
        print(email)
        
        guard validate() else {
            return
        }
        
        do {
            if let user = users.first(where: { $0.email == email && $0.password == password }) {
                currentUser = user
                currentRole = user.role
                fullname = user.name
                isAuthenticated = true
                print("Login başarılı")
            } else {
                throw AuthError.invalidCredentials
            }
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    enum AuthError: LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Geçersiz e-posta veya şifre."
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        showError = false
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Tüm alanları doldurunuz."
            showError = true
            return false
        }
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Geçerli bir email adresi giriniz."
            showError = true
            return false
        }
        
        return true
    }
    
    func logout() async {
        isAuthenticated = false
        currentUser = nil
        currentRole = nil
        email = ""
        password = ""
    }
    
    func getUserName(id : String) -> String {
        loadUsers()
        let user = users.first(where:{$0.id == id})
        
        return user!.name
    }
    
    
    
}

