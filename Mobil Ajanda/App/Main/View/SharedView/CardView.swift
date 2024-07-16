//
//  CardView.swift
//  Mobil Ajanda
//
//  Created by Arda Kulaksız on 14.07.2024.
//

import SwiftUI

struct CardView: View {
    
    var meeting : Meeting
    
    var body: some View {
        
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
                }//h stack inner
                
                
            }
                //outter hstack
        }
        .padding(8)
        
        
        
        
        
    }//body view
}

struct TodayView_Previews2: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        authViewModel.currentUser = User(id: "1", name: "Ali Arda Kulaksız", email: "arda.kulaksiz@tedas.gov.tr", password: "123456", role: .manager)
        return TodayView(meetingViewModel: MeetingViewModel(viewModel: authViewModel), authViewModel: authViewModel)
    }
}
