//
//  UserViewModel.swift
//  TimerApp
//
//  Created by Mary Berridge on 10/5/2026.
//

import Foundation
import Combine
import SwiftUI

class UserViewModel: ObservableObject {
    
    @AppStorage("username") var username: String = ""
    @AppStorage("isSetupCompleted") var isSetupCompleted: Bool = false
    
    @Published var setupCompleted: Bool = false
    
    init() {
        self.setupCompleted = UserDefaults.standard.bool(forKey: "isSetupCompleted")
    }
    
    func completeSetup(name: String) {
        username = name
        isSetupCompleted = true
        setupCompleted = true
    }
    
    func resetUser() {
        username = ""
        isSetupCompleted = false
        setupCompleted = false
    }
    
    //hardcoded values for stats
    //change the placeholder values of 0 to a func that calculates those values
    @AppStorage("totalPoints") var totalPoints: Int = 0
    @AppStorage("totalSessions") var totalSessions: Int = 0
    @AppStorage("totalCycles") var totalCycles: Int = 0
    @AppStorage("totalEggsHatched") var totalEggsHatched: Int = 0
    
    //switch statement changing namecard image depending on total points value
    var namecardImage: String {
        switch totalPoints {
        case 0..<15:
            return "nameCardLv1"
        case 15..<30:
            return "nameCardLv2"
        default:
            return "nameCardLv3"
        }
    }
    
    //array for list, holding stats and their values. struct located in User Model.
    var userStats: [UserStudyStats] {[
        UserStudyStats(studyStat: "Sessions Completed: ", studyStatValue: totalSessions),
        UserStudyStats(studyStat: "Cycles Completed: ", studyStatValue: totalCycles),
        UserStudyStats(studyStat: "Total Points: ", studyStatValue: totalPoints),
        UserStudyStats(studyStat: "Eggs Hatched: ", studyStatValue: totalEggsHatched)
    ]}
    
    func updateStats(points: Int, cycles: Int, eggStage: Int) {
        totalPoints += points
        totalSessions += 1
        totalCycles += cycles
        if eggStage >= 4 {
            totalEggsHatched += 1
        }
    }
    
    //function to add results to study stats, incomplete placeholder
    func addSessionResults(points: Int, isCycleFinished: Bool, cycleAmount: Int) {
        self.totalPoints += points
        self.totalSessions += 1
        if isCycleFinished {
            self.totalCycles += cycleAmount
            self.totalEggsHatched += 1
        }
    }
    
    //note: maybe move colour variables for view UI here too??
}
