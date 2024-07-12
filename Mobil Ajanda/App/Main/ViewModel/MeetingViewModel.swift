import Foundation
import Observation

@Observable
class MeetingViewModel {
    var errorMessage: String = ""
    var showError: Bool = false
    var isAuthenticated: Bool = true
    var viewModel: AuthViewModel
    public var meetings: [Meeting] = []

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        loadMeetings()
        
        Task {
            await filterMeetings()
        }
    }
    
    private func loadMeetings() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            if let mockMeetingsJSON = mockMeetingsJSON {
                let meetingData = try decoder.decode([String: [Meeting]].self, from: mockMeetingsJSON)
                if let meetings = meetingData["meetings"] {
                    self.meetings = meetings
                }
            }
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    
    func filterMeetings() async {
        guard let user = viewModel.currentUser else { return }
        
        switch user.role {
        case .manager:
            meetings = meetings.filter { $0.managerId == user.id }
        case .driver:
            meetings = meetings.filter { $0.driverId == user.id }
        case .securityChief:
            print("full access -> no filter meetings")
        }
    }
    
    func groupedMeetingsByDay() -> [String: [Meeting]] {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            return Dictionary(grouping: meetings) { meeting in
                formatter.string(from: meeting.date)
            }
        }
    
    
  
    
}


func sectionHeader(for day: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    if let date = formatter.date(from: day), Calendar.current.isDateInToday(date) {
        return "BUGÜN"
    } else {
        return day
    }
}


extension DateFormatter {
    static let shortDateAndTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

extension MeetingViewModel {
    func todayMeetings() -> [Meeting] {
        let today = Calendar.current.startOfDay(for: Date())
        return meetings.filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
    }
}

func currentDay() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d" // Sadece gün
    return formatter.string(from: Date())
}
