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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerViewModel)
                .environmentObject(userViewModel)
                .environmentObject(tasksViewModel)
                .environmentObject(eggViewModel)
        }
    }
}
