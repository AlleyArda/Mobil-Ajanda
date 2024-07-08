import SwiftUI

struct MeetingDetailView: View {
    var meeting: Meeting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(meeting.title)
                .font(.largeTitle)
            Text(meeting.location)
                .font(.title)
            Text("\(meeting.date, formatter: dateFormatter)")
                .font(.title)
            Text(meeting.notes ?? "")
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Görüşme Detayı")
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
