import Foundation

struct Meeting: Identifiable, Codable {
    var id: String
    var title: String
    var location: String
    var date: Date
    var notes: String?
}
