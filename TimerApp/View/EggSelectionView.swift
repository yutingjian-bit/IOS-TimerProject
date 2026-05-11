//
//  EggSelectionView.swift
//  TimerApp
//
//  Created by Mary Berridge on 10/5/2026.
//


import SwiftUI
 
 
struct EggSelectionView: View {
    
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
                        Image("titleCardA")
                            .resizable()
                            .frame(width: 400, height: 160)
                        //.padding(.top, 10)
                            .padding(.trailing, 10)
                        
                        Text("Egg Selection")
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
                        
                        Text("Hello World/ Can use as Instruction Text")
                            .font(.title2)
                            .frame(width: 320, height: 60)
                            .foregroundColor(Color.black)
                            .padding(.bottom, 20)
                            .padding(.top, 10)
                        
                        //nav link
                        NavigationLink(destination: StudySessionView(), label: {
                            Text("Start Study Session")
                                .foregroundColor(outlineColourBrown)
                                .frame(maxWidth: 300)
                                .frame(height:50)
                                .font(.title2)
                                .background(buttonColourYellow)
                                .clipShape(Capsule())
                            
                                .padding(.bottom,260)
                        })
                    }
                }
            }
        }
    }
}
 
#Preview {
    NavigationView {
        EggSelectionView()
    }
}
