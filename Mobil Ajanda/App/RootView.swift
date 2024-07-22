import SwiftUI
/*
 
 ManagerView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
 
 
 */


struct RootView: View {
    @State var viewmodel = AuthViewModel()
    @AppStorage("isOn") var isOn = false
    @State private var selection = 2
    var body: some View {
        VStack {
            if viewmodel.isAuthenticated {
                switch viewmodel.currentRole {
                case .manager, .driver, .securityChief:
                    TabView(selection: $selection) {
                        
                        OtherView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                            .tabItem { Label("Program" , systemImage: "magnifyingglass") }.tag(1)
                        
                        TodayView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                            .tabItem { Label("Bugün" , systemImage: "calendar" )
                            }.tag(2)
                        
                        SettingsView( authViewModel: viewmodel).tabItem { Label("Ayarlar" , systemImage: "gear")
                        }.tag(3)
                        
                        
                    }//tabView
                case .none:
                    Text("Kullanıcı rolü belirlenemedi")
                }
            } else {
                AuthView(viewModel: viewmodel)
            }
        }
        //.tint(.black)
    }
}

#Preview {
    RootView()
}
