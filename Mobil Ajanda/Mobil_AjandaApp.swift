// App/ContentView.swift
//jul 12
import SwiftUI
import UserNotifications

@main
struct MobilAjandaApp: App {
    
    init(){
            requestNotificationPermissions()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }//body
}//app

private func requestNotificationPermissions(){
    Task{
        
        let authorazationCenter = UNUserNotificationCenter.current()
        
        do{
            let success = try await authorazationCenter.requestAuthorization(options: [.alert,.badge,.sound])
            
            if success{
                print("success apporoved")
            }
            else{
                print("success denied")
            }
            
        }//do
        catch{
            print(error.localizedDescription)
        }//catch
        
    }
}//func
