//jul 9 15.06
import Foundation

enum UserRole: String, Codable {
    case manager
    case driver
    case securityChief
}

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let password: String
    let role: UserRole
}
