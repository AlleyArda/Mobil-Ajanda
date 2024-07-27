import SwiftUI
import PagerTabStripView
import MapKit
import CoreLocation

struct MeetingDetailView: View {
    var meeting: Meeting
    @AppStorage("isOnHaptic") var isOnHaptic = true
    
    var body: some View {
        VStack {
            PagerTabStripView {
                DetailsView(meeting: meeting)
                    .pagerTabItem(tag: 1) {
                        PageItem(title: "Detaylar")
                    }
                MapView(meeting: meeting)
                    .pagerTabItem(tag: 2) {
                        PageItem(title: "Konum")
                    }
            }
        }
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
    @AppStorage("notes") var notes: String = ""
    @FocusState private var focusedField: Field?
    @State private var isNotesExpanded: Bool = false

    enum Field {
        case notes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            VStack {
                HStack {
                    Spacer()
                    Text("Notlarım")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isNotesExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isNotesExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.blue)
                    }
                }
                .padding(10)
                .background(Color.white.opacity(0.75))
                .cornerRadius(7)
                .padding(5)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                

                if isNotesExpanded {
                    TextEditor(text: $notes)
                        .padding(10)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(7)
                        .padding(5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .focused($focusedField, equals: .notes)
                        
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Button("Bitti") {
                                    focusedField = nil
                                }
                                Spacer()
                            }
                        }
                    
                }
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.secondary)
                    Text("Yönetici Adı:")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(meeting.managerName ?? "error")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image(systemName: "car.fill")
                        .foregroundColor(.secondary)
                    Text("Sürücü Adı:")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(meeting.driverName ?? "error")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(10)
            .background(Color.white.opacity(0.75))
            .cornerRadius(7)
            .padding(5)
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            
            Divider()
            
            HStack {
                
                VStack(alignment: .center
                       , spacing: 5) {
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
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.75))
                .cornerRadius(7)
                .padding(5)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                
            }//hstack
            
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
        .padding()
    }
}

struct MapView: View {
    var meeting: Meeting
    @State private var searchText = ""
    
    var userLocation: CLLocationCoordinate2D {
        .init(latitude: meeting.latitude, longitude: meeting.longitude)
    }
    @State private var region: MKCoordinateRegion
    
    init(meeting: Meeting) {
        self.meeting = meeting
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: meeting.latitude, longitude: meeting.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: [meeting]) { _ in
                MapAnnotation(coordinate: userLocation) {
                    VStack {
                        Image("tedas-logo")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(5)
                        Button(action: {
                            openMapsAppWithDirections(to: userLocation, destinationName: meeting.location)
                        }) {
                            HStack {
                                Text("Haritalar")
                                    .fontWeight(.bold)
                                Image(systemName: "arrowshape.turn.up.right.fill")
                            }
                            .padding(10)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.green]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName: String) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = destinationName
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager)
        return MeetingDetailView(meeting: Meeting(id: "1", title: "deneme", location: "123", date: Date(), managerId: "123", driverId: "123", notes: "123", latitude: 25.7602, longitude: -80.1959, managerName: "arda", driverName: "hakan"))
    }
}
