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
    
    var body: some View {
        NavigationView{
            VStack{
                //Spacer()
                Text("PomEggDoro")
                    .font(.largeTitle)
                    .bold()
                    .padding(20)
                
                Text("Hatch your productivity companion")
                
                
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
                    
                    Image("Egg1b") //cat
                        .resizable()
                        .scaledToFit()
                        .frame(width: 260, height: 250)
                }
                
                
                
                .padding(10)
                
                
                Spacer()
                
                Text("Tap anywhere to start")
                    .font(.title2)
                    .foregroundColor(.blue)
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

