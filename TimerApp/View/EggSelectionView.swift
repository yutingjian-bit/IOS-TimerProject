//
//  EggSelectionView.swift
//  TimerApp
//
//  Created by Mary Berridge on 10/5/2026.
//


import SwiftUI

struct EggSelectionView: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    @State private var selectedEgg: String = "Egg1"
    
    //colour palette variables
    var buttonColourBlue = Color(red: 114/255, green: 182/255, blue: 215/255)
    var buttonColourYellow = Color(red: 255/255, green: 215/255, blue: 85/255)
    var outlineColourBrown = Color(red: 57/255, green: 33/255, blue: 21/255)
    
    // egg type names match asset catalogue
    let eggOptions: [(id: String, label: String)] = [
        ("Egg1", "1"),
        ("Egg2", "2"),
        ("Egg3", "3")
    ]
    
    var body: some View {
        ZStack {
            //gradient background
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.white.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ZStack {
                Rectangle()
                    .fill(.white)
                    .cornerRadius(30)
                    .frame(width: 360, height: 220)
                    .padding(.bottom, 25)
                
                VStack(spacing: 0) {
                    
                    ZStack {
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
                            .padding(.top, 45)
                    }
                    .padding(.bottom, 20)
                    
                    VStack{
                        Text("Select the egg you would like to\nhatch in this study session")
                            .font(.title2)
                            .frame(width: 320, height: 100)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.black)
                            .padding(.top, 10)
                            .padding(.bottom, 50)
                    }
                    
                    VStack{
                        HStack(spacing: 20) {
                            ForEach(eggOptions, id: \.id) { egg in
                                EggOptionButton(
                                    eggId: egg.id,
                                    isSelected: selectedEgg == egg.id,
                                    buttonColourYellow: buttonColourYellow
                                ) {
                                    selectedEgg = egg.id
                                }
                            }
                        }
                    }
                    .padding(.bottom, 30)
                    
                VStack{
                    Text(selectionLabel(for: selectedEgg))
                        .font(.body)
                        .foregroundColor(outlineColourBrown)
                        .padding(.bottom, 5)
                    
                    Text("Remember to not get distracted or quit the app! Your egg may take longer to hatch...")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(width: 280)
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 200)
                    
                    //nav link
                    NavigationLink(destination: TaskView().environmentObject(timerViewModel), label: {
                        Text("Go to Task Planner")
                            .foregroundColor(outlineColourBrown)
                            .frame(maxWidth: 300)
                            .frame(height: 50)
                            .font(.title2)
                            .background(buttonColourYellow)
                            .clipShape(Capsule())
                            .padding(.bottom,100)
                    })
                    // saves selected egg to timerViewModel before navigating
                    .simultaneousGesture(TapGesture().onEnded {
                        timerViewModel.selectedEggType = selectedEgg
                    })
                }
            }
        }
    }
    
    func selectionLabel(for eggId: String) -> String {
        switch eggId {
        case "Egg1": return "You have selected the first Egg."
        case "Egg2": return "You have selected the second Egg."
        case "Egg3": return "You have selected the third Egg."
        default: return ""
        }
    }
}

// MARK: - Egg Option Button
struct EggOptionButton: View {
    let eggId: String
    let isSelected: Bool
    let buttonColourYellow: Color
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                Image("\(eggId)a")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                
                if isSelected {
                    Circle()
                        .stroke(buttonColourYellow, lineWidth: 4)
                        .frame(width: 82, height: 82)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        EggSelectionView()
            .environmentObject(TimerViewModel())
    }
}
