//
//  ResultsView.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: TimerViewModel
    
    @State private var appear = false
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var eggViewModel: EggViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors:[
                    Color(red: 0.98, green: 0.94, blue: 0.86), Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
           
            VStack(spacing: 0) {
                Spacer(minLength: 7)
                
                ZStack {
                    if viewModel.eggStage <= 2 {
                        Image("titleCardA")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 160)
                            
                    } else {
                        Image("titleCardB")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 160)
                            
                    }
                    
                    VStack(spacing: 6) {
                        Text("Cycle complete")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                            
                    }
                    
                    .offset(y: 18)
                }
            
                  
                Spacer().frame(height: 15)
                 
                
                    
                Image(currentEggImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 220)
                    .shadow(color: .gray.opacity(0.3), radius: 12, x: 0, y: 8)
                    .scaleEffect(appear ? 1.0 : 0.8)
                    .opacity(appear ? 1 : 0)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1), value: appear)
                    
                Spacer().frame(height: 20)
                    
                    
                VStack(spacing: 12) {
                    Text(currentStatus())
                        .font(.title2.bold())
                        .foregroundColor(.blue)
                        
                        
                    Text(currentMotivation())
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        
                }
                
                    
                Spacer().frame(height: 30)
                    
                
                
                // progress bar
                VStack(spacing: 8) {
                    HStack {
                        Text("Egg Evolution")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Stage \(viewModel.eggStage)/\(viewModel.totalCycles)")
                            .font(.caption.bold())
                            .foregroundColor(.blue)
                    }
                        
                        
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.15))
                                .frame(height: 8)
                            Capsule()
                                .fill(Color.green)
                                .frame(width: geometry.size.width * CGFloat(evolutionProgress), height: 8)
                                .animation(.easeOut(duration: 0.5), value: evolutionProgress)
                        }
                    }
                    .frame(height: 8)
                }
                .padding(.horizontal, 32)
                    
                Spacer().frame(height: 35)
                    
                
                // statistics
                HStack(spacing: 20) {
                    StatItem(value: "+\(viewModel.pointsEarnedThisSession)", label: "earned", color: .green)
                    StatItem(value: "\(viewModel.totalPoints)", label: "total", color: .orange)
                    StatItem(value: "\(viewModel.totalStudySessions)", label: "completed", color: .blue)
                    
                }
                .padding(.horizontal, 28)
                    
                    
                Spacer().frame(height: 28)
                    
                    
                // sucess rate and points
                HStack {
                    HStack {
                        Image(systemName: "checkmark")
                            .font(.subheadline)
                            .foregroundColor(.green)
                        Text("\(Int(viewModel.successRate))% success")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "gift")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                        Text("\(nextRewardPoints) pts to next")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 32)
                    
                Spacer()
                    
                
                
                
                Button(action: {
                    // update hatched egg
                    eggViewModel.addHatchedEgg(eggType: viewModel.selectedEggType)
                    
                    // update stats
                    userViewModel.updateStats(
                        points: viewModel.finalTotalPoints,
                        cycles: viewModel.finalCompletedCycles,
                        eggStage: viewModel.finalEggStage
                    )
                    
                    //update eggs hatched
                   // userViewModel.totalEggsHatched = eggViewModel.totalEggsHatched
                    
                    viewModel.goHome.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        viewModel.resetForHomeScreen()
                        
                    }
                    
                }) {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("Back to Home")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color(red: 57/255, green: 33/255, blue: 21/255))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(color: .brown.opacity(0.3), radius: 8, x: 0, y: 5)
                }
                .padding(.horizontal, 24)
                
                    
            }
        }
        .onAppear {
            appear = true
        }
    }
    
    func currentEggImage() -> String {
        let stage = viewModel.eggStage
        let suffix = stage == 1 ? "a" : stage == 2 ? "b" : stage == 3 ? "c" : "d"
        return "\(viewModel.selectedEggType)\(suffix)"
    }
        
    func nameCardImage() -> String {
        switch viewModel.eggStage {
        case 2: return "nameCardLv1"
        case 3: return "nameCardLv2"
        case 4: return "nameCardLv3"
        default: return "nameCardLv1"
        }
    }
        
        
    var evolutionProgress: Double {
        Double(viewModel.eggStage) / Double(viewModel.totalCycles)
    }
        
    var nextRewardPoints: Int {
        let next = ((viewModel.totalPoints / 50) + 1) * 50
        return max(0, next - viewModel.totalPoints)
    }
        
    
    func currentStatus() -> String {
        switch viewModel.eggStage {
        case 1: return "A cute egg"
        case 2: return "Small cat"
        case 3: return "Sitting cat"
        case 4: return "Standing cat"
        default: return "A cute egg"
        }
    }
        
        
    func currentMotivation() -> String {
        switch viewModel.eggStage {
        case 1: return "Keep trying, you're doing great!"
        case 2: return "You're getting closer to your goal!"
        case 3: return "You're doing amazing!"
        case 4: return "Congratulations, you're a cat parent!"
        default: return "Keep trying, you're doing great!"
        }
    }
}



struct StatItem: View {
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    ResultsView(viewModel: TimerViewModel())
        .environmentObject(UserViewModel())
        .environmentObject(EggViewModel())
}
