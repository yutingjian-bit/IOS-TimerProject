//
//  TimerAppApp.swift
//  TimerApp
//
//  Created by Camille Jian on 30/4/2026.
//

import SwiftUI

@main
struct TimerAppApp: App {
    
    @StateObject var timerViewModel = TimerViewModel()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var tasksViewModel = TasksViewModel()
    @StateObject var eggViewModel = EggViewModel()
    @State private var isOnLanding = true
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                Group{
                    //new user check
                    if !userViewModel.isSetupCompleted{
                        WelcomeView()
                            .environmentObject(userViewModel)
                    }else{
                        HomeScreenView()
                            .environmentObject(timerViewModel)
                            .environmentObject(tasksViewModel)
                            .environmentObject(userViewModel)
                            .environmentObject(eggViewModel)
                        
                            .id(timerViewModel.goHome)
                    }
                }
                //landing view
                if isOnLanding{
                    ContentView(dismissAction: {
                        isOnLanding = false
                    })
                }
            }
            
        }
    }
}
