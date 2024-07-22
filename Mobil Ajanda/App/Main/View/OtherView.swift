import SwiftUI
import AlertToast

struct OtherView: View {
    @State var meetingViewModel: MeetingViewModel
    @State var authViewModel: AuthViewModel
    @State var navigateToSettings = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if authViewModel.currentUser != nil {
                        meetingsListView
                            .listStyle(.plain)
                            .bold()
                            .toast(isPresenting: $meetingViewModel.showError) {
                                AlertToast(displayMode: .alert, type: .error(.red), title: "Uyarı", subTitle: meetingViewModel.errorMessage)
                            }
                    } else {
                        Text("Kullanıcı bilgisi bulunamadı")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .onAppear {
                    Task {
                        await meetingViewModel.filterMeetings()
                    }
                }
                .navigationTitle(Text("Tüm Toplantılar"))
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        profileMenu
                    }
            }
            }
            NavigationLink(destination: SettingsView(), isActive: $navigateToSettings) {
                            EmptyView()
                        }
        }//navView
        
    }

    private var meetingsListView: some View {
        List {
            ForEach(sortedDays(), id: \.self) { day in
                meetingsSection(for: day)
            }
        }
    }

    private func sortedDays() -> [String] {
        Array(meetingViewModel.groupedMeetingsByDay().keys.sorted())
    }

    private func meetingsSection(for day: String) -> some View {
        Section(header: Text(sectionHeader(for: day))) {
            ForEach(meetings(for: day)) { meeting in
                NavigationLink(destination: MeetingDetailView(meeting: meeting)) {
                    CardView(meeting: meeting)
                        .background(Color.white.gradient.opacity(0.75))
                        .cornerRadius(7)
                        .padding(8)
                        .background(Color.blue.gradient.opacity(2))
                        .cornerRadius(10)
                        
                }
            }
        }
    }

    private func meetings(for day: String) -> [Meeting] {
        meetingViewModel.groupedMeetingsByDay()[day] ?? []
    }
    
    private var profileMenu: some View {
        Menu {
            Button(action: {
                navigateToSettings = true
                print("Settings tapped")
            }) {
                Label("Settings", systemImage: "gear")
            }
            
            Button(action: {
                Task {
                    await authViewModel.logout()
                }
            }) {
                Label("Logout", systemImage: "arrow.right.circle")
            }
        } label: {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
        }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager)
        return OtherView(meetingViewModel: MeetingViewModel(viewModel: authViewModel), authViewModel: authViewModel)
    }
}
