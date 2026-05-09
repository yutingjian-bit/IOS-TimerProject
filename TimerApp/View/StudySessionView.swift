//
//  StudySessionView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI


struct StudySessionView: View {
    
    @Environment(\.dismiss) var dismissToHome
    
    @StateObject private var viewModel = TimerViewModel()
    
    @State private var newTaskName: String = ""
   
    
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
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.showResults = true
                        }) {
                            Image(systemName: "chart.bar.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .gray.opacity(0.2), radius: 5)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                
                Spacer(minLength: 30)
                
               
                
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.1)
                        .foregroundColor(viewModel.currentMode == .study ? .blue : .yellow)
                    
                    
                    Circle()
                        .trim(from: 0, to: viewModel.progress)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .foregroundColor(viewModel.currentMode == .study ? .blue : .orange)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear, value: viewModel.progress)
                    
                    
                    Image(viewModel.currentEggImageName())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 260, height: 260)
                        .shadow(radius: 5)
                        .animation(.easeInOut, value: viewModel.eggStage)
                      
                    
                }
                .frame(width: 320, height: 320)
                
                Spacer(minLength: 30)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today's tasks")
                        .font(.footnote.bold())
                        .foregroundColor(.secondary)
                    
                    ScrollView {
                        if viewModel.tasks.isEmpty {
                            Text("No tasks yet.")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach($viewModel.tasks) { $task in
                                HStack {
                                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isDone ? .green : .gray)
                                        .font(.body)
                                        .onTapGesture {
                                            withAnimation (.easeInOut(duration: 0.3)) {
                                                viewModel.toggleTask(id: task.id)
                                            }
                                        }
                                    Text(task.title)
                                        .font(.callout)
                                        .strikethrough(task.isDone)
                                        .foregroundColor(task.isDone ? .gray : .primary)
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
                                .fill(viewModel.currentMode == .study ? Color.blue : Color.green)
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
        }
        .onChange(of: viewModel.goHome) { oldValue, newValue in
            if newValue {
                viewModel.pauseTimer()
                dismissToHome()
            }
        }
        
    }
}

#Preview {
    StudySessionView()
}
