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
        VStack {
            ZStack{
                Text("UserName")
                    .font(.largeTitle)
                    .padding(30)
                //overlay username on top of namecard image later
                //image would go here
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
            
            // place an image/logo here to fill the white space?
        
            Spacer(minLength:230)
            
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
        
        }
        .padding()
    }
}


#Preview {
    HomeScreenView()
}
