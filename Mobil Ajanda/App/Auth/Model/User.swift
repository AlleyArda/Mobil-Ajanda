struct User: Identifiable, Codable {
    var id: Int
    var name: String
    var email: String
    var password: String
    var role: UserRole
}

enum UserRole: String, Codable {
    case manager
    case driver
    case securityChief
}

