// App/Agenda/View/MainView.swift
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MeetingViewModel()
    var currentUser: User
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchQuery)
                List(viewModel.meetings) { meeting in
                    NavigationLink(destination: MeetingDetailView(meeting: meeting)) {
                        MeetingRow(meeting: meeting)
                    }
                }
                .navigationTitle("Günlük Görüşmeler")
            }
            .onAppear {
                viewModel.fetchMeetings(for: currentUser)
            }
        }
    }
}



