//
//  WelcomeView.swift
//  TimerApp
//
//  Created by Mary Berridge on 11/5/2026.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    @State private var usernameInput: String = ""
    
    let limit = 29
    
    //colour palette variables. move to a new view model file???
    var buttonColourBlue = Color(red:114/255, green: 182/255, blue: 215/255)
    
    var buttonColourYellow = Color(red:255/255, green: 215/255, blue: 85/255)
    
    var outlineColourBrown = Color(red:57/255, green: 33/255, blue: 21/255)
    
    var body: some View{
        //VStack{
        ZStack{
            //gradient background
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.white.opacity(0.1)] ,
                
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Image("Egg4c")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.top, 600)
            
            //white rectangle background. Feel free to adjust size and padding to fit and position any content you want it to fit, or if not needed, delete/uncomment.
            ZStack{
                Rectangle()
                    .fill(.white)
                    .cornerRadius(30)
                    .frame(width:360, height:180)
                    .padding(.bottom, 25)
                
                
                VStack{
                    VStack{
                        VStack{
                    ZStack{
                        Image("titleCardA")
                            .resizable()
                            .frame(width: 400, height: 160)
                            //.padding(.bottom, 200)
                            .padding(.trailing, 10)
                        
                        Text("Welcome!")
                            .font(.largeTitle)
                        //.bold()
                            .frame(width: 300, height: 60)
                        //  .background(Color.blue.opacity(0.5))
                            .foregroundColor(Color.black)
                            .cornerRadius(15)
                            .padding(.top,50 )
                    }
                    .padding(.bottom,30)
                }
                    
                    VStack{
                        
                        
                        Text("Welcome to PomEggDoro, a study timer app where your focus is rewarded with collectable pets!")
                            .font(.title2)
                            .frame(width: 320, height: 100)
                            .foregroundColor(Color.black)
                           .padding(.bottom, 80)
                            .multilineTextAlignment(.center)
                    }
                    VStack{
                        Text("**What should we call you?**")
                            .font(.title3)
                            .frame(width: 320, height: 10)
                            .foregroundColor(Color.black)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack{
                        
                        //textbox
                        TextField("Enter your name...", text: $usernameInput)
                            .textFieldStyle(.roundedBorder)
                            .fontWeight(.bold)
                            .padding(.horizontal, 100)
                            .frame(width: 500,)
                        
                        //char counter
                        Text("\(usernameInput.count)/ \(limit)")
                            .font(.body)
                            .foregroundColor(usernameInput.count >= limit ? .red : buttonColourBlue)
                            .frame(maxWidth: 300, alignment: .trailing)
                    }
                    .padding(.bottom, 130)
                        
                        //button
                        Button{
                            if !usernameInput.isEmpty{
                                viewModel.completeSetup(name: usernameInput)
                            }
                        }label: {
                            Text("Get Started")
                                .font(.title2)
                                .frame(maxWidth: 280)
                                .frame(height:35)
                        }
                            .buttonStyle(.borderedProminent)
                            .tint(buttonColourYellow)
                            .foregroundStyle(outlineColourBrown)
                            .buttonBorderShape(.capsule)
                            .disabled(usernameInput.isEmpty)
                 
                    }
                    .padding(.bottom, 220)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        WelcomeView()
            .environmentObject(UserViewModel())
    }
}
