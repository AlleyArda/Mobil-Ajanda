// App/RootView/RootView.swift
import SwiftUI

struct RootView: View {
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            switch authViewModel.currentUser?.role {
            case .manager:
                MainView(currentUser: authViewModel.currentUser!)
            case .driver:
                DriverView(currentUser: authViewModel.currentUser!)
            case .securityChief:
                MainView(currentUser: authViewModel.currentUser!) // Şimdilik manager gibi görsün
            case .none:
                LoginView()
            }
        } else {
            LoginView()
        }
    }
}
