// App/RootView/RootView.swift
import SwiftUI

struct RootView: View {
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainView(currentUser: authViewModel.currentUser!)
            } else {
                LoginView()
            }
        }
    }
}
