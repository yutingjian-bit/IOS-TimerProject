//
//  ContentView.swift
//  TimerApp
//
//  Created by Camille Jian on 30/4/2026.
//

import SwiftUI

struct HomeScreenView: View {
    //for namecard display based on point values
    @StateObject  var viewModel = UserViewModel()
    
   
   // @EnvironmentObject var userVm: UserViewModel
    
    //colour palette variables. move to a new view model file???
    var buttonColourBlue = Color(red:114/255, green: 182/255, blue: 215/255)
    
    var buttonColourYellow = Color(red:255/255, green: 215/255, blue: 85/255)
    
    var outlineColourBrown = Color(red:57/255, green: 33/255, blue: 21/255)
    
    var body: some View {
        NavigationView{
            ZStack{
                //gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.white.opacity(0.1)] ,
                    
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    
                    ZStack{
                        
                        Image(viewModel.namecardImage)
                            .resizable()
                            .frame(width: 350, height: 80)
                        
                        Text("UserName")
                            .font(.largeTitle)
                            .padding(30)
                        //overlay username on top of namecard
                    }
                    
                    Spacer()
                    
                    //list displaying a users' cumulative stats from userviewmodel
                    List{
                        Section(header: Text("Total Study Stats")
                            .font(.title2)
                            .foregroundStyle(.black)) {
                                ForEach(viewModel.userStats){ stat in HStack{
                                    Text(stat.studyStat)
                                    Spacer()
                                    Text("\(stat.studyStatValue)")
                                        .font(.subheadline)
                                }
                                    //changes the colour of the rows inside the list
                                .listRowBackground(Color.white)
                                    
                                }
                                
                            }
                        
                    }
                    .frame(height: 260)
                    .scrollContentBackground(.hidden)
                    //.background(yellowColour)
                    // rounds the list background frames corners
                    //.clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    //^ un/comment the background and clipShape modifiers to bring back/remove the list frame in the UI
                    
                    //image
                    ZStack{
                        Image("Egg1a") //left egg
                            .resizable()
                            .scaledToFit()
                            .frame(width: 390, height: 190, alignment: .leading)
                        
                        Image("Egg3a") //left egg
                            .resizable()
                            .scaledToFit()
                            .frame(width: 390, height: 190, alignment: .trailing)
                        
                        Image("Egg4a") //middle egg
                            .resizable()
                            .scaledToFit()
                            .frame(width: 280, height: 230)
                        
                        Image("Egg1b") //cat
                            .resizable()
                            .scaledToFit()
                            .frame(width: 260, height: 200)
                    }
                    
                    
                    NavigationLink(destination: SettingsView(), label: {
                        Text("Start A Study Session")
                            .foregroundColor(outlineColourBrown)
                            .frame(maxWidth: 300)
                            .frame(height:50)
                            .font(.title2)
                            .background(buttonColourBlue)
                            .clipShape(Capsule())
                    })
                    
                    .padding(10)
                    
                    NavigationLink(destination: GalleryView(), label: {
                        Text("View Collected Eggs")
                            .foregroundColor(outlineColourBrown)
                            .frame(maxWidth: 300)
                            .frame(height:50)
                            .font(.title2)
                            .background(buttonColourYellow)
                            .clipShape(Capsule())
                    })
                    
                    Spacer()
                        .padding()
                    
                }
        }
    }
        
    }
}


#Preview {
    HomeScreenView()
       // .environmentObject(userViewModel())
}
