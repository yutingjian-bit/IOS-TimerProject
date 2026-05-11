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
        
    @Published var totalStudySessions = 0
    
    
    // shared task pool
    // the timer screen will automtically detect and display the tasks from the task planner
    @Published var tasks: [TasksItem] = []
    
    @Published var studyDuration: Int = 25
    
    @Published var restDuration: Int = 5
    
    @Published var totalCycles: Int = 4
    
    @Published var pointsEarnedThisSession: Int = 0
    
    @Published var pointsLostThisSession: Int = 0
    
    @Published var selectedEggType: String = "Egg1"
    
    @Published var showResults: Bool = false
    
    @Published var goHome: Bool = false
    
    @Published var isCycle4Completed: Bool = false
    
    @Published var finalTotalPoints: Int = 0
    
    @Published var finalCompletedCycles: Int = 0
    
    @Published var finalEggStage: Int = 0
    
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
    
    var successRate: Double {
        let total = successfulSessions + failedSessions
        return total > 0 ? (Double(successfulSessions) / Double(total)) * 100 : 100
    }
    
    // helps to loop automatically
    var eggStage: Int {
        let cyclePosition = totalStudySessions % totalCycles
        
        if showResults || currentMode == .rest {
            // display the stage we just completed
            return (cyclePosition == 0 && totalStudySessions > 0) ? 4 : max(1, cyclePosition)
        } else {
            return cyclePosition + 1
        }
    }
    
    func currentEggImageName() -> String {
        let suffix: String
        switch eggStage {
        case 1: suffix = "a"
        case 2: suffix = "b"
        case 3: suffix = "c"
        case 4: suffix = "d"
        default: suffix = "a"
        }
        return "\(selectedEggType)\(suffix)"
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
        // penalise success rate if user resets the timer during a focus cycle/session
        if currentMode == .study && timeRemaining > 0 {
            failedSessions += 1
        }
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
            completeStudySession()
        } else {
            completeRestSession()
        }
    }
    
    
    
    
    
    private func completeStudySession() {
        pauseTimer()
        
        totalStudySessions += 1
        successfulSessions += 1
        
        let earned = 10
        totalPoints += earned
        pointsEarnedThisSession = earned
        pointsLostThisSession = 0
        
        
        if eggStage > 1 {
            totalPoints += 5
        }
        // help us to check if we just completed the 4th cycle in the loop
        isCycle4Completed = (totalStudySessions > 0 && totalStudySessions % totalCycles == 0)
        
        if isCycle4Completed {
            finalTotalPoints = totalPoints
            finalCompletedCycles = totalStudySessions
            finalEggStage = eggStage
            
            showResults = true
        } else {
            currentMode = .rest
            timeRemaining = restDuration * 60
            startTimer()
        }
        
    }
    
    
    
    
    func startLongBreak() {
        showResults = false
        currentMode = .rest
        timeRemaining = 15 * 60
        startTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(15 * 60)) { [weak self] in
            self?.goHome = true
        }
    }
    
    func completeRestSession() {
        pauseTimer()
        
        if timeRemaining == 0 && currentMode == .rest && showResults == false {
            goHome = true
        } else {
            currentMode = .study
            timeRemaining = studyDuration * 60
            startTimer()
        }
    }

    
    
    func skipBreakAndStartNewCycle() {
        showResults = false
        pauseTimer()
        currentMode = .study
        timeRemaining = studyDuration * 60
        startTimer()
    }
    
    
    // hard reset
    func startNewSession() {
        currentMode = .study
        timeRemaining = studyDuration * 60
        isRunning = false
        totalStudySessions = 0
        successfulSessions = 0
        pointsLostThisSession = 0
        pointsEarnedThisSession = 0
        totalPoints = 0
        failedSessions = 0
        timer?.cancel()
    }
    
    
    // task management: it specifically used to check off tasks and move completed tasks to the bottom
    func toggleTask(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].isComplete.toggle()
            
        }
    }
    
    func addTask(taskName: String, cycle: Int) {
        let newTask = TasksItem(taskName: taskName, cycle: cycle, isComplete: false)
        tasks.append(newTask)
    }
    
    func tasksForCycle(_ cycle: Int) -> [TasksItem] {
        return tasks.filter { $0.cycle == cycle }
    }
    
}
