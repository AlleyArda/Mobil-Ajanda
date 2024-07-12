// App/ContentView.swift
//jul 9 15.06
import SwiftUI

@main
struct MobilAjandaApp: App {
    
    init(){
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.backgroundColor = .systemBlue
//        UINavigationBar.appearance().standardAppearance = navBarAppearance // normal durumda nav bar stilinin davranışı
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance // scroll edilince nav bar stilinin davranışı
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
