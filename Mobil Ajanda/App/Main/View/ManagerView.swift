import SwiftUI
import AlertToast

struct ManagerView: View {
    @State var meetingViewModel: MeetingViewModel
    @State var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            TopView(title: "Bugün", background: .blue)
            if authViewModel.currentUser != nil {
                List {
                    ForEach(meetingViewModel.todayMeetings(), id: \.id) { meeting in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(meeting.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(meeting.location)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(DateFormatter.shortDateAndTime.string(from: meeting.date))
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(meeting.notes)
                                .font(.body)
                                .foregroundColor(.primary)
                            Text("Yönetici ID: \(meeting.managerId)")
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())
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
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            Task {
                await meetingViewModel.filterMeetings()
            }
        }
    }
}

struct EmptyView: View {
    @State var meetingViewModel: MeetingViewModel
    @State var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            TopView(title: "Tüm Toplantılar", background: .blue)
            if authViewModel.currentUser != nil {
                List {
                    ForEach(Array(meetingViewModel.groupedMeetingsByDay().keys.sorted()), id: \.self) { day in
                        Section(header: Text(sectionHeader(for: day))) {
                            ForEach(meetingViewModel.groupedMeetingsByDay()[day]!) { meeting in
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(meeting.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(meeting.location)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text(DateFormatter.shortDateAndTime.string(from: meeting.date))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(meeting.notes)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Text("Yönetici ID: \(meeting.managerId)")
                                        .font(.body)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
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
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            Task {
                await meetingViewModel.filterMeetings()
            }
        }
    }
}





#Preview {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager) // Test amacıyla currentUser'ı ayarla
    return Group {
        ManagerView(meetingViewModel: MeetingViewModel(viewModel: authViewModel), authViewModel: authViewModel)
        EmptyView(meetingViewModel: MeetingViewModel(viewModel: authViewModel), authViewModel: authViewModel)
    }
}
