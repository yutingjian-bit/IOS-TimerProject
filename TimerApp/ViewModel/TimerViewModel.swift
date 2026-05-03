//
//  TimerViewModel.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI
import Combine

enum TimerMode {
    case study, rest
}

class TimerViewModel: ObservableObject {
    
    @Published var timeRemaining: Int = 25 * 60
    
    @Published var currentMode: TimerMode = .study
    
    @Published var isRunning = false
    
    @Published var totalPoints = 0
    
    @Published var eggStage = 1
    
    @Published var totalStudySessions = 0
    
    @Published var showingLongBreakAlert = false
    
    
    @Published var studyDuration: Int = 25
    
    @Published var restDuration: Int = 5
    
    @Published var totalCycles: Int = 4
    
    
    private var timer: AnyCancellable?
    
    private var successfulSessions = 0
    
    private var failedSessions = 0
    
    
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var progress: Double {
        let total = currentMode == .study ? studyDuration * 60 : restDuration * 60
        return 1 - (Double(timeRemaining) / Double(total))
    }
    
    var sucessRate: Double {
        let total = successfulSessions + failedSessions
        return total > 0 ? (Double(successfulSessions) / Double(total)) * 100 : 100
    }
    
    func eggIcon() -> String {
        switch eggStage {
        case 1: return "🥚"
        case 2: return "🥚🔍"
        case 3: return "🐱🥚"
        case 4: return "🐱"
        default: return "🥚"
        }
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func pauseTimer() {
        isRunning = false
        timer?.cancel()
    }
    
    
    func resetTimer() {
        pauseTimer()
        timeRemaining = currentMode == .study ? studyDuration * 60 : restDuration * 60
    }
    
    func skipRest() {
        guard currentMode == .rest else { return }
        pauseTimer()
        completeRestSession()
    }
    
    func forceCompleteSession() {
        pauseTimer()
        
        if currentMode == .study {
                completeStudySession()
            } else {
                completeRestSession()
            }
    }
    
    private func tick() {
        guard timeRemaining > 0 else {
            completeSession()
            return
        }
        timeRemaining -= 1
    }
    
    private func completeSession() {
        pauseTimer()
        
        if currentMode == .study {
            completeSession()
        } else {
            completeRestSession()
        }
    }
    
    private func completeStudySession() {
        totalStudySessions += 1
        successfulSessions += 1
        totalPoints += 10
        
        if totalStudySessions % 2 == 0 && eggStage < 4 {
            eggStage += 1
            totalPoints += 5
        }
        
        if totalStudySessions >= totalCycles {
            showingLongBreakAlert = true
        } else {
            currentMode = .rest
            timeRemaining = restDuration * 60
            startTimer()
        }
    }
    
    private func completeRestSession() {
        currentMode = .study
        timeRemaining = studyDuration * 60
        startTimer()
    }
    
    func startLongBreak() {
        showingLongBreakAlert = false
        currentMode = .rest
        timeRemaining = 15 * 60
        startTimer()
    }
    
    
    func startNewSession() {
        currentMode = .study
        timeRemaining = studyDuration * 60
        isRunning = false
        totalStudySessions = 0
        successfulSessions = 0
        eggStage = 1
        totalPoints = 0
        failedSessions = 0
        timer?.cancel()
    }
}
