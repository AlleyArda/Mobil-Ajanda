//
//  ProfileMenu.swift
//  Mobil Ajanda
//
//  Created by Arda Kulaksız on 15.07.2024.
//

import SwiftUI

struct ProfileMenu: View {
    var body: some View {
        var profileMenu: some View {
            Menu {
                Button(action: {
                    // Action for settings
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
}

#Preview {
    ProfileMenu()
}
