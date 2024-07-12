import SwiftUI
/*
 
 ManagerView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
 
 
 */
struct RootView: View {
    @State var viewmodel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewmodel.isAuthenticated {
                    switch viewmodel.currentRole {
                    case .manager, .driver, .securityChief:
                        TabView {
                            TodayView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                                .tabItem { Label("Bugün" , systemImage: "calendar" )}
                            OtherView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                                .tabItem { Label("Diğer Toplantılar" , systemImage: "ellipsis") }
                        }//tabView
                        .navigationBarBackButtonHidden(true)
                    case .none:
                        Text("Kullanıcı rolü belirlenemedi")
                    }
                } else {
                    AuthView(viewModel: viewmodel)
                }
            }
        }
    }
}

#Preview {
    RootView()
}
