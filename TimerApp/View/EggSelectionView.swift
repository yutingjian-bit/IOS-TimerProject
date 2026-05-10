//
//  EggSelectionView.swift
//  TimerApp
//
//  Created by Amenah Al-Saegh on 6/5/2026.
//

import SwiftUI
 
// The 4 egg types matching your asset names
struct EggOption: Identifiable {
    let id          = UUID()
    let eggType:      String   // "Egg1", "Egg2", "Egg3", "Egg4"
    let imageName:    String   // the 'a' egg image shown during selection
    let eggName:      String
    let description:  String
}
 
struct EggSelectionView: View {
    // Passed in from SettingsView so settings carry through to StudySession
    @ObservedObject var timerViewModel: TimerViewModel
 
    let eggOptions: [EggOption] = [
        EggOption(eggType: "Egg1", imageName: "Egg1a", eggName: "Blue Egg",    description: "Hatches a white cat"),
        EggOption(eggType: "Egg2", imageName: "Egg2a", eggName: "Orange Egg",  description: "Hatches an orange tabby"),
        EggOption(eggType: "Egg3", imageName: "Egg3a", eggName: "Dark Egg",    description: "Hatches a dark cat"),
        EggOption(eggType: "Egg4", imageName: "Egg4a", eggName: "Royal Egg",   description: "Hatches a royal cat"),
    ]
 
    // Which egg is tapped — default to first
    @State private var selectedEggType: String = "Egg1"
 
    var selectedOption: EggOption {
        eggOptions.first { $0.eggType == selectedEggType } ?? eggOptions[0]
    }
 
    var body: some View {
        VStack(spacing: 20) {
 
            // Title
            Text("Egg Selection")
                .font(.largeTitle)
                .bold()
                .frame(width: 300, height: 60)
                .background(Color.yellow.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.top, 30)
 
            Text("Select the egg you would like to hatch\nin this study session")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal, 20)
 
            // Egg row
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(eggOptions) { option in
                        Button {
                            selectedEggType = option.eggType
                        } label: {
                            VStack(spacing: 8) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(selectedEggType == option.eggType
                                              ? Color.yellow.opacity(0.20)
                                              : Color.gray.opacity(0.08))
                                        .frame(width: 110, height: 130)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(
                                                    selectedEggType == option.eggType
                                                    ? Color.yellow : Color.clear,
                                                    lineWidth: 3.5
                                                )
                                        )
 
                                    Image(option.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 85, height: 105)
                                }
 
                                Text(option.eggName)
                                    .font(.caption)
                                    .fontWeight(selectedEggType == option.eggType ? .bold : .regular)
                                    .foregroundColor(selectedEggType == option.eggType ? .primary : .secondary)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 100)
                            }
                        }
                        .scaleEffect(selectedEggType == option.eggType ? 1.07 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6),
                                   value: selectedEggType)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
            }
 
            // Selection feedback
            VStack(spacing: 6) {
                Text("You selected: \(selectedOption.eggName)")
                    .font(.headline)
                Text(selectedOption.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.yellow.opacity(0.20))
            .cornerRadius(12)
            .padding(.horizontal, 30)
 
            Text("Don't quit the app during your session —\nyour egg may take longer to hatch!")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 30)
 
            Spacer()
 
            // Pass selected egg type and settings into TaskView → StudySession
            NavigationLink(destination: TaskView(timerViewModel: timerViewModel)) {
                Text("Continue to Task Planning")
                    .foregroundColor(.white)
                    .frame(maxWidth: 300)
                    .frame(height: 50)
                    .font(.title2)
                    .background(Color.yellow)
                    .clipShape(Capsule())
            }
            .simultaneousGesture(TapGesture().onEnded {
                timerViewModel.selectedEggType = selectedEggType
            })
            .padding(.bottom, 40)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
 
#Preview {
    NavigationView {
        EggSelectionView(timerViewModel: TimerViewModel())
    }
}
