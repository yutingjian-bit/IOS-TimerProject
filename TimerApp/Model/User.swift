//
//  User.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import Foundation

//for displaying a list of user stats on the homescreen view
struct userStudyStats: Identifiable{
    var id = UUID()
    let studyStat: String
    let studyStatValue: Int 
}

struct userDetails: Identifiable, Codable{
    var id = UUID()
    let password: String
    let userName: String
}
