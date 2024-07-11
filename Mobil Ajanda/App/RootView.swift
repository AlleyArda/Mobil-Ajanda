import SwiftUI

struct RootView: View {
    @State var viewmodel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewmodel.isAuthenticated {
                    switch viewmodel.currentRole {
                    case .manager, .driver, .securityChief:
                        ManagerView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
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
