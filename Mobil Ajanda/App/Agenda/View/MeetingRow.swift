import SwiftUI

struct MeetingRow: View {
    var meeting: Meeting
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(meeting.title)
                .font(.headline)
            Text(meeting.location)
                .font(.subheadline)
            Text("\(meeting.date, formatter: dateFormatter)")
                .font(.subheadline)
        }
    }
}
