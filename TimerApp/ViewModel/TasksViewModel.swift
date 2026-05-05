//
//  TasksViewModel.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import Foundation
import Combine
import SwiftUI

class TasksViewModel: ObservableObject{
    @Published var tasks: [TasksItem] = []
    
    func addTask(taskName: String, cycle: Int){
        let newTask = TasksItem (taskName: taskName, cycle: cycle)
        tasks.append(newTask)
    }
    
    func deleteTask (at offsets: IndexSet){
        tasks.remove(atOffsets: offsets)
    }
    func updateCompletion(for task: TasksItem){
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isComplete.toggle()
        }
    }
    func cycleTask(_ index: Int) -> [TasksItem] {
        return tasks.filter {$0.cycle == index}
    }
}
