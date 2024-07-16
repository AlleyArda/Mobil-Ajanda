import SwiftUI
import PagerTabStripView
import MapKit
//12 Jul
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
        //.toolbar(.hidden, for: .tabBar)
        
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
    @State var authViewModel = AuthViewModel()
    @State var meetingViewModel = MeetingViewModel(viewModel: AuthViewModel())
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text(meeting.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.secondary)
                        Text(meeting.location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.secondary)
                        Text(DateFormatter.shortDateAndTime.string(from: meeting.date))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
                Spacer()
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    
                    Image(systemName: "person.fill")
                        .foregroundColor(.secondary)
                    Text("Yönetici Adı:")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("BLANK")
                    /*Text(authViewModel.getUserName(id: meeting.managerId))
                        .font(.subheadline)
                        .foregroundColor(.secondary)*/
                    
                }
                
                HStack {
                    
                    Image(systemName: "car.fill")
                        .foregroundColor(.secondary)
                    Text("Sürücü Adı:")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("BLANK")
                    /* Text(authViewModel.getUserName(id: meeting.driverId))
                        .font(.subheadline)
                        .foregroundColor(.secondary) */
                    
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            
            Spacer()
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



#Preview{
    RootView()
}
/* struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        let meeting = Meeting(id: "1", title: "Project Meeting", location: "Discuss project scope", date: Date(), managerId: "1", driverId: "manager1", notes: "driver1")
        DetailsView(meeting: meeting, authViewModel: authViewModel)
    }
}

*/
