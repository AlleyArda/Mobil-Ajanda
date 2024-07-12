import SwiftUI
import AlertToast

struct TodayView: View {
    @State var meetingViewModel: MeetingViewModel
    @State var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // TopView(title: "Toplantılar", subtitle: "BUGÜN" , background: .blue)
                if authViewModel.currentUser != nil {
                    List(meetingViewModel.todayMeetings()) {  meeting in
                        VStack(alignment: .leading) {
                            NavigationLink(destination: MeetingDetailView(meeting: meeting)) {
                                
                                
                                
                                VStack (alignment: .leading){
                                    Text(meeting.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    
                                    Text(meeting.notes)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    
                                    
                                    HStack {
                                        
                                        HStack {
                                            Image(systemName: "map")
                                            Text(meeting.location)
                                                .font(.footnote)
                                                .bold()
                                        }
                                        Spacer()
                                        Divider()
                                        Spacer()
                                        
                                        HStack {
                                            Image(systemName: "calendar")
                                            
                                            Text(meeting.date.formatted())
                                                .font(.footnote)
                                                .italic()
                                        }
                                        
                                        
                                    }
                                }
                                .padding(8)
                                
                            }
                            .padding(8)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                        }
                    }
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
            .toolbar {
                ToolbarItem {
                    Button("Profil", systemImage: "person") {
                        print("")
                        
                    }
                    .buttonStyle(.plain)
                    //.tint(.blue)
                }
            }

        }
        
    }
}

#Preview {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager) // Test amacıyla currentUser'ı ayarla
    return TodayView(meetingViewModel: MeetingViewModel(viewModel: authViewModel), authViewModel: authViewModel)
    
}
