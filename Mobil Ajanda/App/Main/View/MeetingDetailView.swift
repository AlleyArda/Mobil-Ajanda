import SwiftUI
import PagerTabStripView
import MapKit

struct MeetingDetailView: View {
    var meeting: Meeting
    
    var body: some View {
        VStack {
            
            PagerTabStripView() {
                DetailsView(meeting: meeting)
                    .pagerTabItem(tag: 1) {
                        PageItem(title: "Detaylar")
                    }
                MapView(meeting: meeting)
                    .pagerTabItem(tag: 2) {
                        PageItem(title: "Harita")
                    }
                
            }
            
        }
        .toolbar(.hidden, for: .tabBar)

    }
}

struct PageItem: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        VStack {
            Map()
        }
    }
}

