//
//  GalleryView.swift
//  TimerAppProject
//
//  Created by Amenah Al-Saegh on 10/5/2026.
//

import SwiftUI

struct GalleryView: View {
    
    @EnvironmentObject var eggViewModel: EggViewModel
    
    //colour palette variables
    var buttonColourBlue = Color(red: 114/255, green: 182/255, blue: 215/255)
    var buttonColourYellow = Color(red: 255/255, green: 215/255, blue: 85/255)
    var outlineColourBrown = Color(red: 57/255, green: 33/255, blue: 21/255)
    
    // 2-column grid for the hatched egg cards
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
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
            
            VStack(spacing: 0) {
                
                ZStack {
                    Image("titleCardA")
                        .resizable()
                        .frame(width: 400, height: 160)
                        .padding(.trailing, 10)
                    
                    Text("Egg Gallery")
                        .font(.largeTitle)
                        .frame(width: 300, height: 60)
                        .foregroundColor(Color.black)
                        .cornerRadius(15)
                        .padding(.top, 45)
                }
                
                // empty state if no eggs hatched yet
                if eggViewModel.hatchedEggs.isEmpty {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Image("Egg1a")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .opacity(0.4)
                        
                        Text("No eggs hatched yet!")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Complete a full study cycle to\nhatch your first egg.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray.opacity(0.8))
                    }
                    
                    Spacer()
                    
                } else {
                    // scrollable grid of all hatched eggs
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(eggViewModel.hatchedEggs) { egg in
                                HatchedEggCard(egg: egg, outlineColourBrown: outlineColourBrown)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}

// displays a single hatched egg with its name and date
struct HatchedEggCard: View {
    let egg: HatchedEgg
    let outlineColourBrown: Color
    
    var body: some View {
        VStack(spacing: 8) {
            // stage "d" = standing cat, the fully hatched form
            Image("\(egg.eggType)d")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
            
            Text(egg.nickname)
                .font(.headline)
                .foregroundColor(outlineColourBrown)
            
            Text("Hatched \(egg.dateHatched, style: .date)")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.1), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    NavigationView {
        GalleryView()
            .environmentObject(EggViewModel())
    }
}
