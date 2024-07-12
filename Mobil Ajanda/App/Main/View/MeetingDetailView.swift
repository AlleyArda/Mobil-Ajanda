import SwiftUI

struct MeetingDetailView: View {
    var meeting: Meeting
    
    var body: some View {
        TabView {
            DetailsView(meeting: meeting)
                .tabItem {
                    Label("Details", systemImage: "info.circle")
                }

            MapView(meeting: meeting)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

struct DetailsView: View {
    var meeting: Meeting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(meeting.title)
                .font(.headline)
                .foregroundColor(.primary)
            Text(meeting.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(DateFormatter.shortDateAndTime.string(from: meeting.date))
                .font(.caption)
                .foregroundColor(.secondary)
            Text(meeting.notes)
                .font(.body)
                .foregroundColor(.primary)
            Text("Yönetici ID: \(meeting.managerId)")
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding()
        .navigationTitle("Meeting Details")
    }
}

struct MapView: View {
    var meeting: Meeting
    
    var body: some View {
        Text("Map for \(meeting.location)")
            .font(.title)
            .foregroundColor(.gray)
            .navigationTitle("Meeting Location")
    }
}

