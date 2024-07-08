import Foundation

class AuthService {
    static let shared = AuthService()
    
    private var users: [User] = []
    
    private init() {
        loadUsers()
    }
    
    private func loadUsers() {
        if let url = Bundle.main.url(forResource: "users", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let usersData = try decoder.decode([String: [User]].self, from: data)
                if let users = usersData["users"] {
                    self.users = users
                }
            } catch {
                print("Error loading users: \(error)")
            }
        }
    }
    
    func authenticate(email: String, password: String) -> User? {
        return users.first { $0.email == email && $0.password == password }
    }
}
