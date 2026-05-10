//
//  GalleryView.swift
//  TimerAppProject
//
//  Created by Amenah Al-Saegh on 10/5/2026.
//

import SwiftUI
 
struct GalleryView: View {
    @StateObject var eggStore = EggViewModel()
 
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
 
    let yellowColour = Color(red: 255/255, green: 247/255, blue: 216/255)
 
    var body: some View {
        VStack(spacing: 0) {
 
            Text("Egg Gallery")
                .font(.largeTitle)
                .bold()
                .frame(width: 300, height: 60)
                .background(Color.yellow.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.top, 20)
 
            Text("\(eggStore.collectedEggs.count) egg\(eggStore.collectedEggs.count == 1 ? "" : "s") collected")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.vertical, 10)
 
            if eggStore.collectedEggs.isEmpty {
                Spacer()
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        Image("Egg1a").resizable().scaledToFit().frame(width: 60, height: 70)
                        Image("Egg2a").resizable().scaledToFit().frame(width: 60, height: 70)
                        Image("Egg3a").resizable().scaledToFit().frame(width: 60, height: 70)
                        Image("Egg4a").resizable().scaledToFit().frame(width: 60, height: 70)
                    }
                    .opacity(0.4)
 
                    Text("No eggs yet!")
                        .font(.title2).bold()
 
                    Text("Complete all 4 study cycles\nto hatch your first egg!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 40)
                }
                Spacer()
 
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(eggStore.collectedEggs) { egg in
                            VStack(spacing: 6) {
                                Image(egg.finalImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 90)
 
                                Text(egg.displayName)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
 
                                Text("Session \(egg.sessionNumber)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 6)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.yellow.opacity(0.5), lineWidth: 2)
                            )
                            .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
                        }
                    }
                    .padding(16)
                }
                .background(yellowColour)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 12)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Gallery")
        .navigationBarTitleDisplayMode(.inline)
    }
}
 
#Preview {
    NavigationView {
        GalleryView()
    }
}
