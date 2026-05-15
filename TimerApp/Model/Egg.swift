//
//  Egg.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import Foundation
struct HatchedEgg: Identifiable,Codable {
    var id = UUID()
    var eggType: String
    var nickname: String
    var dateHatched: Date
}
