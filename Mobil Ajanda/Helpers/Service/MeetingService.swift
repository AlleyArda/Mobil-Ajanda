// App/Helpers/Service/MeetingService.swift
import Foundation

class MeetingService {
    static let shared = MeetingService()
    
    private var meetings: [Meeting] = []
    
    private init() {
        loadMeetings()
    }
    
    private func loadMeetings() {
        let data = Data(mockMeetingsJSON.utf8)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let meetingsData = try decoder.decode([String: [Meeting]].self, from: data)
            if let meetings = meetingsData["meetings"] {
                self.meetings = meetings
                print("Meetings loaded: \(meetings)")
            }
        } catch {
            print("Error loading meetings: \(error)")
        }
    }
    
    func getMeetings(for user: User) -> [Meeting] {
        switch user.role {
        case .manager, .securityChief:
            return meetings
        case .driver:
            return meetings.filter { $0.driverId == user.id }
        }
    }
}
