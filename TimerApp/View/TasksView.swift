//
//  TasksView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel = TasksViewModel()
    @State private var Task1: String = ""
    @State private var Task2: String = ""
    @State private var Task3: String = ""
    @State private var Task4: String = ""
    @State private var selectedCycle: Int = 1
    
    var body: some View {
            VStack{
                Text("Task Planning")
                    .font(.title)
                    .bold()
                    .frame(width: 300, height: 60)
                    .background(Color.yellow.opacity(0.7))
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                
                Text("List the tasks you aim to complete in each cycle:")
                    .font(.default)
                    .bold()
                    .frame(width: 310, height: 60)
                    .background(Color.red.opacity(0.6))
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .padding(.bottom, 20)
                
                TextField("Task 1...", text: $Task1)
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.black)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 100)
                    .frame(width: 500,)
                
                TextField("Task 2...", text: $Task2)
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.black)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 100)
                    .frame(width: 500)
                
                TextField("Task 3...", text: $Task3)
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.black)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 100)
                    .frame(width: 500)
                
                TextField("Task 4...", text: $Task4)
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.black)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 100)
                    .frame(width: 500)
                
                
                NavigationLink(destination: StudySessionView(), label: {
                    Text("Start Session")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 300)
                        .frame(height:50)
                        .font(.title2)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
        }
            .padding(.bottom,300)
          
    }
}

#Preview {
    TaskView()
}


