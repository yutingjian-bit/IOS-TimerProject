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
    
    @StateObject var tasksViewModel = TasksViewModel()
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            if timerViewModel.goHome {
                HomeScreenView()
                    .environmentObject(timerViewModel)
                    .environmentObject(tasksViewModel)
                    .environmentObject(userViewModel)
                
                    .onAppear {
                        timerViewModel.goHome = false
                        timerViewModel.startNewSession()
                    }
            } else  {
                HomeScreenView()
                    .environmentObject(timerViewModel)
                    .environmentObject(tasksViewModel)
                    .environmentObject(userViewModel)
            }

        }
    }
}
