import Foundation
import Observation
import MapKit

@Observable
class MeetingViewModel {
    var errorMessage: String = ""
    var showError: Bool = false
    var isAuthenticated: Bool = true
    var searchQuery: String = "" {
        didSet {
            searchMeetings()
        }
    }
    var viewModel: AuthViewModel
    public var meetings: [Meeting] = []
    public var filteredMeetings: [Meeting] = []
    public var searchedMeetings: [Meeting] = []

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
                if var meetings = meetingData["meetings"] {
                    // Meeting içindeki managerName ve driverName değerlerini ayarlayalım
                    for index in meetings.indices {
                        meetings[index].managerName = viewModel.getUserName(id: meetings[index].managerId)
                        meetings[index].driverName = viewModel.getUserName(id: meetings[index].driverId)
                    }
                    self.meetings = meetings
                    self.filteredMeetings = meetings
                    self.searchedMeetings = meetings
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
            filteredMeetings = meetings.filter { $0.managerId == user.id }
        case .driver:
            filteredMeetings = meetings.filter { $0.driverId == user.id }
        case .securityChief:
            filteredMeetings = meetings // full access, no filtering
        }
        searchMeetings()
    }
    
    private func searchMeetings() {
        if searchQuery.isEmpty {
            searchedMeetings = filteredMeetings
        } else {
            searchedMeetings = filteredMeetings.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    func groupedMeetingsByDay() -> [String: [Meeting]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return Dictionary(grouping: searchedMeetings) { meeting in
            formatter.string(from: meeting.date)
        }
    }
    
    func todayMeetings() -> [Meeting] {
        let today = Calendar.current.startOfDay(for: Date())
        return searchedMeetings.filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
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

func currentDay() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d" // Sadece gün
    return formatter.string(from: Date())
}
