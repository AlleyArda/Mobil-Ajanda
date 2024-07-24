import SwiftUI
import AlertToast

struct TodayView: View {
    
    @State var meetingViewModel: MeetingViewModel
    @State var authViewModel: AuthViewModel
    @State var navigateToSettings = false
    @AppStorage("isOnHaptic") var isOnHaptic = true
    var body: some View {
        NavigationStack {
            VStack {
                if authViewModel.currentUser != nil {
                    todayMeetingsListView
                        .listStyle(.plain)
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
            .navigationTitle("Günün Programı")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    profileMenu
                }
            }
            
           
        }
        
    }

    private var todayMeetingsListView: some View {
        List(meetingViewModel.todayMeetings()) { meeting in
            NavigationLink(destination: MeetingDetailView(meeting: meeting)) {
                CardView(meeting: meeting)
                    .background(Color.blue.gradient.opacity(0.4))
                    .cornerRadius(7)
                    .padding(8)
                    .background(Color.blue.gradient.opacity(0.3))
                    .cornerRadius(10)
            }.listRowSeparator(.hidden)
        }.listRowSeparator(.hidden)
    }

    private var profileMenu: some View {
        Menu {
            Button(action: {
                Task {
                    await authViewModel.logout()
                }
            }) {
                Label("Çıkış", systemImage: "arrow.right.circle")
            }
        } label: {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager)
        return TodayView(meetingViewModel: MeetingViewModel(viewModel: authViewModel), authViewModel: authViewModel)
    }
}
