// App/Agenda/ViewModel/MeetingViewModel.swift
import Foundation
import Combine

class MeetingViewModel: ObservableObject {
    @Published var meetings: [Meeting] = []
    @Published var searchQuery: String = ""
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.filterMeetings(with: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchMeetings(for user: User) {
        currentUser = user
        meetings = MeetingService.shared.getMeetings(for: user)
    }
    
    func filterMeetings(with query: String) {
        if query.isEmpty {
            if let user = currentUser {
                fetchMeetings(for: user)
            }
        } else {
            meetings = meetings.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
    }
}
