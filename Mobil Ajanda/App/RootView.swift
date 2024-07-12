import SwiftUI
/*
 
 ManagerView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
 
 
 */
struct RootView: View {
    @State var viewmodel = AuthViewModel()
    
    var body: some View {
            VStack {
                if viewmodel.isAuthenticated {
                    switch viewmodel.currentRole {
                    case .manager, .driver, .securityChief:
                        TabView() {
                            TodayView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                                .tabItem { Label("Bugün" , systemImage: "calendar" )}
                            
                            OtherView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                                .tabItem { Label("Program" , systemImage: "magnifyingglass") }
                            
                        }//tabView
                    case .none:
                        Text("Kullanıcı rolü belirlenemedi")
                    }
                } else {
                    AuthView(viewModel: viewmodel)
                }
            }    
            .tint(.black)

    }
}

#Preview {
    RootView()
}
