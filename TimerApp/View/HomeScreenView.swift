//
//  ContentView.swift
//  TimerApp
//
//  Created by Camille Jian on 30/4/2026.
//

import SwiftUI

struct HomeScreenView: View {
    //array for list, holdings stats and their values. struct located in User Model.
    let userStats = [
        userStudyStats(studyStat: "Sessions Completed: ", studyStatValue: 0),
        userStudyStats(studyStat: "Cycles Completed: ", studyStatValue: 0),
        userStudyStats(studyStat: "Total Points: ", studyStatValue: 0),
        userStudyStats(studyStat: "Eggs Hatched: ", studyStatValue: 0)
    ]
    
    //colour palette variables. move to a new view model file???
    var yellowColour = Color(red:255/255, green: 247/255, blue: 216/255)
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                
                ZStack{
                    //note: namecards are not yet functional and dont display according to a users number of points
                    Image("nameCardLv1") //starting namecard
                        .resizable()
                        .frame(width: 350, height: 80)
                    
                    Text("UserName")
                        .font(.largeTitle)
                        .padding(30)
                    //overlay username on top of namecard
                }
                
                Spacer()
                
                //list displaying a users' cumulative stats
                List{
                    Section(header: Text("Total Study Stats")
                        .font(.title2)
                        .foregroundStyle(.black)) {
                            ForEach(userStats){ item in HStack{
                                Text(item.studyStat)
                                Spacer()
                                Text("\(item.studyStatValue)")
                                    .font(.subheadline)
                            }
                                //changes the colour of the rows inside the list
                            .listRowBackground(yellowColour)
                                
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
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 300)
                        .frame(height:50)
                        .font(.title2)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
                
                .padding(10)
                
                NavigationLink(destination: GalleryView(), label: {
                    Text("View Collected Eggs")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 300)
                        .frame(height:50)
                        .font(.title2)
                        .background(Color.yellow)
                        .clipShape(Capsule())
                })
                
                Spacer()
                    .padding()
                
            }
    }
        
    }
}


#Preview {
    HomeScreenView()
}
