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
            
            Image("Egg3d")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.top, 600)
            
            //white rectangle background. Feel free to adjust size and padding to fit and position any content you want it to fit, or if not needed, delete/uncomment.
            ZStack{
                Rectangle()
                    .fill(.white)
                    .cornerRadius(30)
                    .frame(width:360, height:280)
                    .padding(.bottom, 85)
                
                
                VStack{
                    VStack{
                    ZStack{
                        Image("titleCardB")
                            .resizable()
                            .frame(width: 400, height: 160)
                        //.padding(.top, 10)
                            .padding(.trailing, 10)
                        
                        Text("Welcome!")
                            .font(.largeTitle)
                        //.bold()
                            .frame(width: 300, height: 60)
                        //  .background(Color.blue.opacity(0.5))
                            .foregroundColor(Color.black)
                            .cornerRadius(15)
                            .padding(.top,45 )
                    }
                        
                }
                    VStack{
                        //NOTE:
                        //add any content for the view here.
                        //this a placeholder text which can be deleted or used as instruction text (e.g. tasks view)
                        //After UI content is added, will need to use padding and spacers to position title card, navigation link button etc.
                        
                        Text("Welcome to PomEggDoro, a study timer app where your focus is rewarded with collectable pets!")
                            .font(.title2)
                            .frame(width: 320, height: 200)
                            .foregroundColor(Color.black)
                            //.padding(.bottom, 20)
                            .padding(.top, 10)
                            .multilineTextAlignment(.center)
                        
                        Text("**What should we call you?**")
                            .font(.title3)
                            .frame(width: 320, height: 200)
                            .foregroundColor(Color.black)
                            .padding(.bottom, 20)
                            //.padding(.top, 10)
                            .multilineTextAlignment(.center)
                        
                        //textbox
                        TextField("Enter your name...", text: $usernameInput)
                            .textFieldStyle(.roundedBorder)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                            .padding(.top,30)
                            .padding(.horizontal, 100)
                            .frame(width: 500,)
                        
                        //char counter
                        Text("\(usernameInput.count)/ \(limit)")
                            .font(.body)
                            .foregroundColor(usernameInput.count >= limit ? .red : buttonColourBlue)
                            .frame(maxWidth: 300, alignment: .trailing)
                    
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
