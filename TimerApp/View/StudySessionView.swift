//
//  StudySessionView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI

struct StudySessionView: View {
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: viewModel.currentMode == .study ? [Color.blue.opacity(0.1), Color.purple.opacity(0.1)] : [Color.green.opacity(0.1), Color.yellow.opacity(0.1)],
                
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
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
                        .fill(viewModel.currentMode == .study ? Color.blue.opacity(0.2) : Color.green.opacity(0.2))
                        
                )
                .padding(.top, 40)
                
                Spacer()
                
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.1)
                        .foregroundColor(viewModel.currentMode == .study ? .blue : .green)
                    
                    
                    Circle()
                        .trim(from: 0, to: viewModel.progress)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .foregroundColor(viewModel.currentMode == .study ? .blue : .orange)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear, value: viewModel.progress)
                    
                    
                    VStack(spacing: 10) {
                        Text(viewModel.eggIcon())
                            .font(.system(size: 80))
                        
                        Text(viewModel.timeString)
                            .font(.system(size: 48, weight: .bold, design: .monospaced))
                        
                        Text(viewModel.currentMode == .study ? "Study time" : "Rest time")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 280, height: 280)
                .padding()
                
                Spacer()
                
                
                
                HStack(spacing: 40) {
                    if viewModel.currentMode == .rest && viewModel.isRunning {
                        Button(action: {viewModel.skipRest()}) {
                            VStack {
                                Image(systemName: "forward.fill")
                                    .font(.title2)
                                Text("Skip")
                                    .font(.caption)
                            }
                            .foregroundColor(.orange)
                        }
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
                    
                    if viewModel.currentMode == .study && !viewModel.isRunning {
                        Button(action: {viewModel.resetTimer()}) {
                            VStack {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.title2)
                                Text("Reset")
                                    .font(.caption)
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                .padding(.bottom, 40)
                
                // Just for testing the rest button functions
                #if DEBUG
                Button(action: {viewModel.forceCompleteSession()}) {
                    Text("Testing functions")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                #endif
                
                HStack {
                    Image(systemName: "Info.circle")
                    Text(viewModel.currentMode == .study ? "Next: Rest \(viewModel.restDuration) mins" : "Next: New Study Session \(viewModel.studyDuration) mins")
                        .font(.caption)
                }
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            }
        }
        .alert("Need a longer break!!", isPresented: $viewModel.showingLongBreakAlert) {
            Button("15 mins break", role: .cancel) {
                viewModel.startLongBreak()
            }
            Button("Continue", role: .destructive) { }
        } message: {
            Text("Congrat! You finished \(viewModel.totalCycles) study cycles!! Recommend resting for 10 - 15 mins")
        }
        
    }
}

#Preview {
    StudySessionView()
}
