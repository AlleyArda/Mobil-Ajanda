import SwiftUI
import AlertToast

struct ManagerView: View {
    @State var meetingViewModel: MeetingViewModel
    @State var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            TopView(title: "Toplantılarım", background: .blue)
            // Başlık alanının yüksekliği
            
            if let currentUser = authViewModel.currentUser { // Nil kontrolü
                List {
                    ForEach(Array(meetingViewModel.groupedMeetingsByDay().keys.sorted()), id: \.self) { day in
                        Section(header: Text(sectionHeader(for: day))) { // Section başlığında kontrol
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
                                .frame(maxWidth: .infinity, alignment: .leading) // Ekran boyunca genişlet
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
    
    // Yardımcı fonksiyon: Section başlığı için kontrol eder ve BUGÜN ya da tarih metnini döner
    func sectionHeader(for day: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: day), Calendar.current.isDateInToday(date) {
            return "BUGÜN"
        } else {
            return day
        }
    }
}

extension DateFormatter {
    static let shortDateAndTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

#Preview {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager) // Test amacıyla currentUser'ı ayarla
    return ManagerView(meetingViewModel: MeetingViewModel(viewModel: authViewModel), authViewModel: authViewModel)
}
