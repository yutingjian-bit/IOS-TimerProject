//
//  TasksView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var tasksViewModel: TasksViewModel
    @State private var Task1: String = ""
    @State private var Task2: String = ""
    @State private var Task3: String = ""
    @State private var Task4: String = ""
    @State private var navigateToStudy = false
    
    
    //colour palette variables. move to a new view model file???
    var buttonColourBlue = Color(red:114/255, green: 182/255, blue: 215/255)
    
    var buttonColourYellow = Color(red:255/255, green: 215/255, blue: 85/255)
    
    var outlineColourBrown = Color(red:57/255, green: 33/255, blue: 21/255)
    
    var body: some View {
        NavigationStack {
            ZStack{
                //gradient bg
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.white.opacity(0.1)] ,
                    
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ZStack{
                    //white background
                    ZStack{
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(30)
                            .frame(width:360, height: 300)
                            .padding(.bottom, 85)

                //white background
                ZStack{
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(30)
                        .frame(width:360, height:320)
                        .padding(.bottom, 15)
                        .padding(.top,175)
                    
                    VStack{
                        ZStack{
                            
                            Image("titleCardA")
                                .resizable()
                                .frame(width: 400, height: 160)
                                //.padding(.top, 10)
                                .padding(.trailing, 10)
                                .padding(.top, 40)
                            
                            Text("Task Planning")
                                .font(.largeTitle)
                                .frame(width: 300, height: 100)
                                .foregroundColor(Color.black)
                                .cornerRadius(15)
                                .padding(.top, 80 )
                            
                        }
                        .padding(.top,100)
                        
                        VStack{
                            
                            ZStack{
                                
                                Image("titleCardA")
                                    .resizable()
                                    .frame(width: 400, height: 160)
                                //.padding(.top, 10)
                                    .padding(.trailing, 10)
                                
                                Text("Task Planning")
                                    .font(.largeTitle)
                                    .frame(width: 300, height: 60)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(15)
                                    .padding(.top, 45 )
                                
                            }
                            
                            Text("List the tasks you aim to complete in each cycle:")
                                .font(.title2)
                            // .bold()

                                .frame(width: 320, height: 70)
                                .foregroundColor(Color.black)
                                .cornerRadius(15)
                                .padding(.bottom, 20)
                                .padding(.top, 10)
                            
                            VStack(spacing: 15){
                                TextField("Task 1...", text: $Task1)
                                    .textFieldStyle(.roundedBorder)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                    .padding(.top,30)
                                    .padding(.horizontal, 100)
                                    .frame(width: 500)
                                
                                TextField("Task 2...", text: $Task2)
                                    .textFieldStyle(.roundedBorder)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                    .padding(.horizontal, 100)
                                    .frame(width: 500)
                                
                                TextField("Task 3...", text: $Task3)
                                    .textFieldStyle(.roundedBorder)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                    .padding(.horizontal, 100)
                                    .frame(width: 500)
                                
                                TextField("Task 4...", text: $Task4)
                                    .textFieldStyle(.roundedBorder)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                    .padding(.horizontal, 100)
                                    .frame(width: 500)
                                
                                    .padding(.bottom, 30)
                                
                                //nav link - leads to egg selection before starting the session
                                
                                
                                
                                // saves tasks to the shared view model before navigating
                                Button {
                                    tasksViewModel.removeAllTasks()
                                 
                                    if !Task1.isEmpty {
                                        tasksViewModel.addTask(taskName: Task1, cycle: 1)
                                    }
                                    
                                    if !Task2.isEmpty {
                                        tasksViewModel.addTask(taskName: Task2, cycle: 2)
                                    }
                                    
                                    if !Task3.isEmpty {
                                        tasksViewModel.addTask(taskName: Task3, cycle: 3)
                                    }
                                    
                                    if !Task4.isEmpty {
                                        tasksViewModel.addTask(taskName: Task4, cycle: 4)
                                    }
                                    
                                    navigateToStudy = true
                                    
                                    
                                } label: {
                                    
                                    Text("Next")
                                        .foregroundColor(outlineColourBrown)
                                        .frame(width: 200, height: 50)
                                        .font(.title2)
                                        .background(buttonColourYellow)
                                        .clipShape(Capsule())
                                        .padding(.bottom, 40)
                                    
                                }
                                

                                .frame(width: 320, height: 60)
                                .foregroundColor(Color.black)
                                .cornerRadius(15)
                                .padding(.bottom, 40)
                                .padding(.top,20)
                            
                            Picker("Cycle", selection: $selectedCycle) {
                                Text("Cycle 1").tag(1)
                                Text("Cycle 2").tag(2)
                                Text("Cycle 3").tag(3)
                                Text("Cycle 4").tag(4)
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 10)
                            .frame(width:440)
                            
                            Spacer(minLength: 50)
                            
                            VStack{
                                HStack {
                                    
                                    Image("Egg1a")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    TextField("Task 1...", text: $Task1)
                                        .textFieldStyle(.roundedBorder)
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .padding(.bottom, 20)
                                        .frame(width: 270, height: 10)
                                }
                                
                                Spacer(minLength: 20)
                                
                                HStack{
                                    Image("Egg2a")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    TextField("Task 2...", text: $Task2)
                                        .textFieldStyle(.roundedBorder)
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .padding(.bottom, 20)
                                        .frame(width: 270)
                                }
                                
                                Spacer(minLength: 20)
                                
                                HStack{
                                    Image("Egg3a")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    TextField("Task 3...", text: $Task3)
                                        .textFieldStyle(.roundedBorder)
                                        .fontWeight(.black)
                                        .padding(.bottom, 20)
                                        .frame(width: 270)
                                }
                                Spacer(minLength: 20)
                                
                                HStack{
                                    Image("Egg4a")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    TextField("Task 4...", text: $Task4)
                                        .textFieldStyle(.roundedBorder)
                                        .fontWeight(.black)
                                        .padding(.bottom, 20)
                                        .frame(width: 270)
                                }
                            }
                            
                            
                                .padding(.bottom, 20)
                            
                            //nav link - leads to egg selection before starting the session
                            NavigationLink(destination: StudySessionView().environmentObject(timerViewModel)) {
                                Text("Next")
                                    .foregroundColor(outlineColourBrown)
                                    .frame(maxWidth: 300)
                                    .frame(height:50)
                                    .font(.title2)
                                    .background(buttonColourYellow)
                                    .clipShape(Capsule())
                                
                                    .padding(.bottom,230)
                                    .padding(.top,50)
                            }
                            
                        }
                        
                    }
                    
                }
                .navigationDestination(isPresented: $navigateToStudy) {
                    StudySessionView()
                        .environmentObject(timerViewModel)
                    
                }
                
            }
            
        }
        
    }
}

#Preview {
    TaskView()
        .environmentObject(TimerViewModel())
        .environmentObject(TasksViewModel())
}

