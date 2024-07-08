import Foundation

enum UserRole: String, Codable {
    case manager
    case driver
    case securityChief
}

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var password: String
    var role: UserRole
}
