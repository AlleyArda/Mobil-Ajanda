// App/Driver/View/DriverView.swift
import SwiftUI

struct DriverView: View {
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
                .navigationTitle("Sürücü Görevleri")
            }
            .onAppear {
                viewModel.fetchMeetings(for: currentUser)
            }
        }
    }
}
