// App/Agenda/ViewModel/MeetingViewModel.swift
import Foundation
import Combine


class MeetingViewModel: ObservableObject {
    @Published var meetings: [Meeting] = []
    @Published var searchQuery: String = ""
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchMeetings()
        
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.filterMeetings(with: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchMeetings() {
        // Dummy data for demonstration
        meetings = [
            Meeting(id: UUID().uuidString, title: "Görüşme 1", location: "Merkez Ofis", date: Date(), notes: "Notlar"),
            // Add more meetings here
        ]
    }
    
    func filterMeetings(with query: String) {
        if query.isEmpty {
            fetchMeetings()
        } else {
            meetings = meetings.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
    }
    
    func filteredMeetings(for user: User) -> [Meeting] {
        switch user.role {
        case .manager:
            return meetings
        case .driver:
            return meetings.map { Meeting(id: $0.id, title: $0.title, location: $0.location, date: $0.date, notes: nil) }
        case .securityChief:
            return meetings
        }
    }
}
