//
//  LandingView.swift
//  TimerApp
//
//  Created by Mary Berridge on 11/5/2026.
//

import Foundation
import SwiftUI
//note: content view is the landing view


struct ContentView: View {
    var dismissAction: ()-> Void
    
    //colour palette variables. move to a new view model file???
    var buttonColourBlue = Color(red:114/255, green: 182/255, blue: 215/255)
    
    var buttonColourYellow = Color(red:255/255, green: 215/255, blue: 85/255)
    
    var outlineColourBrown = Color(red:57/255, green: 33/255, blue: 21/255)
    
    
    var body: some View {
        NavigationView{
            ZStack{
                //gradient background
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.white.opacity(0.1)] ,
                    
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Image("titleCardB")
                            .resizable()
                            .frame(width: 400, height: 160)
                            //.padding(.bottom, 200)
                            .padding(.trailing, 10)
                        
                        //Spacer()
                        Text("PomEggDoro")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(buttonColourBlue)
                            .padding(.top,50)
                }
                   
                    Text("Hatch your productivity companion")
                        .font(.title3)
                        .padding(.top, 10)
                    
                    
                    //image
                    ZStack{
                        Image("Egg1a") //left egg
                            .resizable()
                            .scaledToFit()
                            .frame(width: 420, height: 240, alignment: .leading)
                        
                        Image("Egg3a") //left egg
                            .resizable()
                            .scaledToFit()
                            .frame(width: 420, height: 240, alignment: .trailing)
                        
                        Image("Egg4a") //middle egg
                            .resizable()
                            .scaledToFit()
                            .frame(width: 280, height: 280)
                        
                        Image("Egg2c") //cat
                            .resizable()
                            .scaledToFit()
                            .frame(width: 360, height: 350)
                    }
                    .padding(.top,40)
            
                    Spacer()
                    
                    Text("Tap anywhere to start")
                        .frame(maxWidth: 280)
                        .frame(height:50)
                        .background(buttonColourBlue, in: Capsule())
                        .font(.title2)
                        .foregroundColor(outlineColourBrown)
                        .padding(.bottom, 60)
                    
                        
                    
                    
                }
                .padding(.bottom, 30)
        }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onTapGesture {
                dismissAction()
                
            }
        }
    }
}

#Preview {
    ContentView(dismissAction: {})
}

