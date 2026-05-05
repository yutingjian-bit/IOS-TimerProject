//
//  Tasks.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import Foundation
struct TasksItem: Identifiable{
    let id = UUID()
    var taskName: String
    var cycle: Int
    var isComplete: Bool = false
}
