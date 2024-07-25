import UserNotifications

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
    public var filteredMeetings: [Meeting] = [] {
        didSet {
            // Schedule notifications for filtered meetings
            scheduleNotifications()
        }
    }
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
            filteredMeetings = meetings // Full access, no filtering
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
    
    private func scheduleNotification(for meeting: Meeting) {
        let content = UNMutableNotificationContent()
        content.title = "Meeting Reminder"
        content.body = "Your meeting \(meeting.title) at \(meeting.location) is starting soon."
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: meeting.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: meeting.id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for meeting \(meeting.title)")
            }
        }
    }
    
    private func scheduleNotifications() {
        guard let user = viewModel.currentUser else { return }
        
        let relevantMeetings = filteredMeetings.filter { $0.managerId == user.id || $0.driverId == user.id }
        
        for meeting in relevantMeetings {
            scheduleNotification(for: meeting)
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

func currentDay() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    return formatter.string(from: Date())
}
