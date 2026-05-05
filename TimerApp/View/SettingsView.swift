//
//  SettingsView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = TimerViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing:30){
            Text("Timer Settings")
                .font(.largeTitle)
                .bold()
                .frame(width: 300, height: 60)
                .background(Color.blue.opacity(0.5))
                .foregroundColor(Color.white)
                .cornerRadius(15)
                .padding(.top, 150)
            
            Spacer()
        }

        .padding(.bottom, 5)
        
        VStack(alignment: .leading, spacing:10){
            Text("Total Study Time: \(Int(viewModel.studyDuration)) minutes")
                .font(.headline)
            Divider()
            Slider(
                value: Binding(
                    get: { Double(viewModel.studyDuration) },
                    set: { viewModel.studyDuration = Int($0) }
                ),
                in: 25...45,
                step:1,
                minimumValueLabel: Text("25"),
                maximumValueLabel: Text("45")
            ) {
                Text("study cycle time")
            }
            .tint(.yellow.opacity(0.5))
    
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
        Spacer()
        
        VStack(alignment: .leading, spacing: 10){
            Text("Total Rest Time: \(Int(viewModel.restDuration)) minutes")
                .font(.headline)
            Divider()
            Slider(
                value: Binding(
                    get: { Double(viewModel.restDuration) },
                    set: { viewModel.restDuration = Int($0) }
                ),
                in: 5...10,
                step:1,
                minimumValueLabel: Text("5"),
                maximumValueLabel: Text("10")
            ) {
                Text("study cycle time")
            }
            
            .tint(.red.opacity(0.5))
        }
        .padding(.top, 60)
        .padding(.horizontal, 20)
        
        VStack(alignment: .leading, spacing:10){
            Text("Total Study Cycle: \(Int(viewModel.totalCycles)) Cycles")
                .font(.headline)
            Divider()
            Slider(
                value: Binding(
                    get: { Double(viewModel.totalCycles) },
                    set: { viewModel.totalCycles = Int($0) }
                ),
                in: 2...4,
                minimumValueLabel: Text("2"),
                maximumValueLabel: Text("4")
            ) {
                Text("study cycle time")
            }
            
            .tint(.green.opacity(0.5))
        }
        .padding(.vertical, 60)
        .padding(.horizontal, 20)
        
        NavigationLink(destination: TaskView(), label: {
            Text("Continue to task planning")
                .foregroundColor(Color.white)
                .frame(maxWidth: 300)
                .frame(height:50)
                .font(.title2)
                .background(Color.blue)
                .clipShape(Capsule())
        })
        
     
        .padding(.bottom, 300)
        
        
        
    }
   
    
      //add navi link to next screen -> task planning
    //also add back button
    
}

#Preview {
    SettingsView()
}
