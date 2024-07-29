import SwiftUI

struct RootView: View {
    @State var viewmodel = AuthViewModel()
    @AppStorage("isOn") var isOn = false
    @State private var selection = 2
    @AppStorage("isOnHaptic") var isOnHaptic = true
    var body: some View {
        VStack {
            if viewmodel.isAuthenticated {
                switch viewmodel.currentRole {
                case .manager, .driver, .securityChief:
                    TabView(selection: $selection) {
                        
                        TodayView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                            .tabItem {
                                Label("Bugün", systemImage: "calendar")
                            }
                            .tag(2)
                            .background(GeometryReader { _ in
                                Color.clear.onAppear {
                                    if isOnHaptic {
                                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                    }
                                }
                            })
                        
                        OtherView(meetingViewModel: MeetingViewModel(viewModel: viewmodel), authViewModel: viewmodel)
                            .tabItem {
                                Label("Program", systemImage: "magnifyingglass")
                            }
                            .tag(1)
                            .background(GeometryReader { _ in
                                Color.clear.onAppear {
                                    if isOnHaptic {
                                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                    }
                                }
                            })
                        
                        
                        
                        SettingsView(authViewModel: viewmodel)
                            .tabItem {
                                Label("Ayarlar", systemImage: "gear")
                            }
                            .tag(3)
                            .background(GeometryReader { _ in
                                Color.clear.onAppear {
                                    if isOnHaptic {
                                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                    }
                                }
                            })
                        
                    } // TabView
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
