// App/Agenda/Model/MeetingModel.swift
import Foundation

struct Meeting: Identifiable, Codable {
    var id: String
    var title: String
    var location: String
    var date: Date
    var managerId: String
    var driverId: String
    var notes: String?  // Bu satırı ekleyin
}
