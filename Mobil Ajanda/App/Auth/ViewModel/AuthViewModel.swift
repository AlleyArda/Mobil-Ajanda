import Foundation
import Observation
//jul 9 15.06
@Observable
class AuthViewModel {
    var email: String = ""
    var password: String = ""
    var errorMessage: String = ""
    var showError: Bool = false
    var isAuthenticated: Bool = false
    var fullname: String = ""
    
    
    private var users: [User] = []
    
    init()  {
        loadUsers()
    }
    
    
    private func loadUsers()  {
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
            print(email)
            
            if var user = users.first(where: { $0.email == email && $0.password == password }) {
                isAuthenticated = true
                fullname = user.name
                print("Login başarılı")
            } else {
                throw AuthError.invalidCredentials
            }
        } catch {
            errorMessage = error.localizedDescription
            print(error.localizedDescription)
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
    
    private func logout() {
        // Buraya Logout işlemi için gerekli kodları yazacaksın.
    }
}
