//
//  StudySessionView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI


struct StudySessionView: View {
    
    @Environment(\.dismiss) var dismissToHome
    
    @EnvironmentObject var viewModel: TimerViewModel
    
    @State private var newTaskName: String = ""
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var tasksViewModel: TasksViewModel
   
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: viewModel.currentMode == .study ? [Color.blue.opacity(0.1), Color.white.opacity(0.1)] : [Color.yellow.opacity(0.1), Color.white.opacity(0.1)],
                
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            
            
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        Image(systemName: viewModel.currentMode == .study ? "brain.head.profile" : "cup.and.saucer.fill")
                            .font(.title2)
                        Text(viewModel.currentMode == .study ? "Focusing" : "Resting")
                            .font(.title2.bold())
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(viewModel.currentMode == .study ? Color.blue.opacity(0.2) : Color.yellow.opacity(0.2))
                        
                        
                    )
                    
                    
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                
                Spacer(minLength: 30)
                
               
                
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.1)
                        .foregroundColor(viewModel.currentMode == .study ? Color(red: 114/255, green: 182/255, blue: 215/255) : Color(red: 255/255, green: 215/255, blue: 85/255))
                    
                    
                    Circle()
                        .trim(from: 0, to: viewModel.progress)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .foregroundColor(viewModel.currentMode == .study ? .blue : .orange)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear, value: viewModel.progress)
                    
                    
                    Image(viewModel.currentEggImageName())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 280)
                        .shadow(radius: 5)
                        .animation(.easeInOut, value: viewModel.eggStage)
                      
                    
                }
                .frame(width: 320, height: 320)
                
                Spacer(minLength: 30)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cycle \(viewModel.eggStage) Tasks")
                        .font(.footnote.bold())
                        .foregroundColor(Color(red: 140/255, green: 100/255, blue: 200/255))
                    
                    ScrollView {
                        let currentCycleTasks = tasksViewModel.tasks.filter { $0.cycle == viewModel.eggStage }
                        if currentCycleTasks.isEmpty {
                            Text("No tasks for Cycle \(viewModel.eggStage) yet!")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(currentCycleTasks) { task in
                                HStack {
                                    Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isComplete ? .green : .gray)
                                        .font(.body)
                                        .onTapGesture {
                                            withAnimation (.easeInOut(duration: 0.3)) {
                                                tasksViewModel.toggleTask(id: task.id)
                                            }
                                        }
                                    Text(task.taskName)
                                        .font(.callout)
                                        .strikethrough(task.isComplete)
                                        .foregroundColor(task.isComplete ? .gray : .primary)
                                    Spacer()
                                    
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    .frame(maxHeight: viewModel.tasks.isEmpty ? 40 : 80)
                
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .gray.opacity(0.1), radius: 9)
                .padding(.horizontal, 23)
                
                Spacer(minLength: 30)
                
                
                
                Text(viewModel.timeString)
                    .font(.system(size: 62, weight: .bold, design: .monospaced))
                    
                
                Spacer(minLength: 20)
                
                
                
                
                
                HStack(spacing: 35) {
                    if viewModel.currentMode == .rest {
                        Button(action: {viewModel.skipRest()}) {
                            Image(systemName: "forward.end.fill")
                                .font(.title3)
                                .foregroundColor(.orange)
                                .frame(width: 55, height: 55)
                                .background(Color.orange.opacity(0.15))
                                .clipShape(Circle())
                            
                            }
                    } else {
                        Spacer().frame(width: 55)
                    }
                    
                    
                    
                    Button(action: {
                        if viewModel.isRunning {
                            viewModel.pauseTimer()
                        } else {
                            viewModel.startTimer()
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(viewModel.currentMode == .study ? Color(red: 114/255, green: 182/255, blue: 215/255) : Color(red: 255/255, green: 215/255, blue: 85/255))
                                .frame(width: 80, height: 80)
                                .shadow(radius: 10)
                            
                            Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            
                        }
                    }
                    
                    if viewModel.currentMode == .study {
                        Button(action: {viewModel.resetTimer()}) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.title3)
                                .foregroundColor(.red.opacity(0.8))
                                .frame(width: 55, height:  55)
                                .background(Color.red.opacity(0.15))
                                .clipShape(Circle())
                            }
                    } else {
                        Spacer().frame(width: 55)
                    }
                }
                .padding(.bottom, 20)
                
                // Just for testing the rest button functions
                #if DEBUG
                Button(action: {viewModel.forceCompleteSession()}) {
                    Text("Testing functions")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(.bottom, 20)
                }
                #endif
                
                
            
            }
        }
        
        .fullScreenCover(isPresented: $viewModel.showResults) {
            ResultsView(viewModel: viewModel)
                .environmentObject(userViewModel)
        }
        .onChange(of: viewModel.goHome) { oldValue, newValue in
            if newValue {
                viewModel.pauseTimer()
                
            }
        }
        
    }
}

#Preview {
    StudySessionView()
        .environmentObject(TimerViewModel())
        .environmentObject(UserViewModel())
}
