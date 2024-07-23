import SwiftUI
import PagerTabStripView
import MapKit
import CoreLocation
//12 Jul
struct MeetingDetailView: View {
    var meeting: Meeting
    @AppStorage("isOnHaptic") var isOnHaptic = true
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
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.white.gradient.opacity(0.75))
                .cornerRadius(7)
                .padding(8)
                .background(Color.blue.gradient.opacity(2))
                .cornerRadius(10)
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
            .background(Color.white.gradient.opacity(0.75))
            .cornerRadius(7)
            .padding(5)
            .background(Color.blue.gradient.opacity(2))
            .cornerRadius(10)
            
            Spacer()
            
            //buraya not kısmı gelebilir
            
        }//V outter
        .padding()
        .navigationTitle("Toplantı Ayrıntıları")
    }
}




struct MapView: View {
    var meeting: Meeting
    @State private var searchText = ""
    /*@State private var cameraPosition: MapCameraPosition = .region(.userRegion)*/
    
    var userLocation : CLLocationCoordinate2D{
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
        Map() {
            Annotation("\(meeting.location)", coordinate: userLocation){
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.gradient)
                    Image("tedas-logo")
                        .resizable()
                        .frame(width: 50 ,  height: 50)
                        .padding(5)
                }
                /*.onTapGesture {
                    <#code#>
                }*/
            }
        }
        .overlay(alignment: .topLeading){
            TextField("Arama yap", text: $searchText)
                .font(.subheadline)
                .padding(12)
                .background(.white.gradient.opacity(0.4))
                .padding()
                .shadow(radius: 10)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
        }.onSubmit (of: .text) {
            print("search for locations with query \(searchText)")
        }
        .mapControls{
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        .mapControlVisibility(.visible)
        .edgesIgnoringSafeArea(.all)
    }
    
    
    
}






struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager)
        return MeetingDetailView(meeting: Meeting(id: "1", title: "deneme", location: "123", date: Date(), managerId: "123", driverId: "123", notes: "123", latitude: 25.7602, longitude: -80.1959 , managerName: "arda" , driverName: "hakan"))
    }
}
