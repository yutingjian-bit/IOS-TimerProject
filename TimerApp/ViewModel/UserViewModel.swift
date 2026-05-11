//
//  UserViewModel.swift
//  TimerApp
//
//  Created by Mary Berridge on 10/5/2026.
//

import Foundation
import Combine
import SwiftUI

class UserViewModel: ObservableObject{
    
    //character limit for username
    private let charLimit = 29
    
    //username
    @AppStorage("username") var username: String = ""{
        didSet{
            if username.count > charLimit{
                username = String(username.prefix(charLimit))
            }
        }
    }
    @AppStorage("isSetupCompleted") var isSetupCompleted: Bool = false
    
    func completeSetup(name: String){
        objectWillChange.send()
        self.username = name
        self.isSetupCompleted = true
    }
    
    //hardcoded values for stats. valye is of 0 for now until stats calculation is completed from results view
    //change the placeholder values of 0 to a func that calculates those values

    @AppStorage("totalPoints") var totalPoints: Int = 0
    @AppStorage("totalSessions") var totalSessions: Int = 0
    @AppStorage("totalCycles") var totalCycles: Int = 0
    @AppStorage("totalEggsHatched") var totalEggsHatched: Int = 0
    
    //switch statment chnaging namecard image depending on total points value
    var namecardImage: String{
        switch totalPoints{
        case 0..<15:
            return "nameCardLv1"
        case 15..<30:
            return "nameCardLv2"
        default:
            return "nameCardLv3"
        }
    }
    
    //array for list, holdings stats and their values. struct located in User Model.
    var userStats: [UserStudyStats]{[
        UserStudyStats(studyStat: "Sessions Completed: ", studyStatValue: totalSessions),
        UserStudyStats(studyStat: "Cycles Completed: ", studyStatValue: totalCycles),
        UserStudyStats(studyStat: "Total Points: ", studyStatValue: totalPoints),
        UserStudyStats(studyStat: "Eggs Hatched: ", studyStatValue: totalEggsHatched)
    ]
    }
    
    //func addPoints(_ amount: Int){
    //    totalPoints += amount
   // }
    
    func updateStats(points: Int, cycles: Int, eggStage: Int) {
        totalPoints += points
        totalSessions += 1
        totalCycles += cycles
        if eggStage >= 4 {
            totalEggsHatched += 1
        }
    }
    
    //function to add results to study stats, incomplete placeholder
    func addSessionResults(points: Int, isCycleFinished: Bool, cycleAmount: Int){
        self.totalPoints += points
        self.totalSessions += 1
        if isCycleFinished{
            self.totalCycles += cycleAmount
            self.totalEggsHatched += 1
        }
    }
    
    //note: maybe move colour variables for view UI here too??

}

