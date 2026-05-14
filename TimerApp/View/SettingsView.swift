//
//  SettingsView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    
    //colour palette variables. move to a new view model file???
    var buttonColourBlue = Color(red:114/255, green: 182/255, blue: 215/255)
    
    var buttonColourYellow = Color(red:255/255, green: 215/255, blue: 85/255)
    
    var outlineColourBrown = Color(red:57/255, green: 33/255, blue: 21/255)
    
    var body: some View {
        ZStack{
            //gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.white.opacity(0.1)] ,
                
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            //white background
            ZStack{
                Rectangle()
                    .fill(.white)
                    .cornerRadius(30)
                    .frame(width:360, height:400)
                    .padding(.bottom, 90)
                
                
                VStack{
                    
                    
                    VStack(alignment: .center, spacing:30){
                        ZStack{
                            
                            Image("titleCardA")
                                .resizable()
                                .frame(width: 400, height: 160)
                                .padding(.top, 90)
                                .padding(.trailing, 10)
                            
                            Text("Timer Settings")
                                .font(.largeTitle)
                            //.bold()
                                .frame(width: 300, height: 60)
                            //  .background(Color.blue.opacity(0.5))
                                .foregroundColor(Color.black)
                                .cornerRadius(15)
                                .padding(.top, 140)
                            
                            Spacer()
                        }
                        
                        
                        .padding(.bottom, 20)
                        
                        
                        VStack(alignment: .leading, spacing:10){
                            Text("**Total Study Time:** \(Int(viewModel.studyDuration)) minutes")
                                .font(.body)
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
                        
                        .padding(.top, 10)
                        .padding(.horizontal, 40)
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("**Total Rest Time:** \(Int(viewModel.restDuration)) minutes")
                                .font(.body)
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
                        .padding(.top, 0)
                        .padding(.horizontal, 40)
                        
                        VStack(alignment: .leading, spacing:10){
                            Text("**Total Study Cycles:** \(Int(viewModel.totalCycles)) Cycles")
                                .font(.body)
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
                        .padding(.top, 30)
                        .padding(.horizontal, 40)
                        .padding(.bottom,70)
                        
                        NavigationLink(destination: EggSelectionView().environmentObject(viewModel)){
                            Text("Continue to egg selection")
                                .foregroundColor(outlineColourBrown)
                                .frame(maxWidth: 300)
                                .frame(height:50)
                                .font(.title2)
                                .background(buttonColourYellow)
                                .clipShape(Capsule())
                        }
                        
                        
                        .padding(.bottom, 260)
                        
                    }
                }
            }
            
        }
        
        
    }
}
   
    
      //add navi link to next screen -> task planning
    //also add back button
    


#Preview {
    SettingsView(viewModel: TimerViewModel())
        
}
