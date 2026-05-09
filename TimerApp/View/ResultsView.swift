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
                HStack {
                    Button(action: {
                        viewModel.goHome = true
                        dismiss()
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title2)
                            .foregroundColor(.brown)
                            .padding(12)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.1), radius: 4)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Spacer(minLength: 15)
                
                
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Spacer(minLength: 15)
                        
                        
                        VStack(spacing: 6) {
                            Text("Cycle complete")
                                .font(.largeTitle.bold())
                                .foregroundColor(.primary)
                            
                            Text("Your egg is growing ~")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer(minLength: 25)
                        
                        
                        VStack(spacing: 12) {
                            if viewModel.eggStage >= 2 {
                                Image(nameCardImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 160, height: 50)
                                
                            }
                            
                            
                            Image(currentEggImage())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame( height: 200)
                                .shadow(color: .gray.opacity(0.3), radius: 12, x: 0, y: 8)
                                .scaleEffect(appear ? 1.0 : 0.8)
                                .opacity(appear ? 1 : 0)
                                .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1), value: appear)
                            
                            
                            
                            
                            Text(currentStatus())
                                .font(.title2.bold())
                                .foregroundColor(.blue)
                            
                            
                            Text(currentMotivation())
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 25)
                        
                        // progress bar
                        VStack(spacing: 8) {
                            HStack {
                                Text("Egg Evolution")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Stage \(viewModel.eggStage)/4")
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
                        .padding(.horizontal, 24)
                        
                        Spacer(minLength: 25)
                        
                        // statistics
                        HStack(spacing: 15) {
                            CoreStat(value: "+\(viewModel.pointsEarnedThisSession)", label: "earned", icon: "arrow.up", color: .green)
                            CoreStat(value: "\(viewModel.totalPoints)", label: "total", icon: "star", color: .orange)
                            CoreStat(value: "\(viewModel.totalStudySessions)", label: "completed", icon: "repeat", color: .blue)
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 15)
                        
                        
                        HStack {
                            HStack {
                                Image(systemName: "checkmark")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                Text("\(Int(viewModel.sucessRate))% success")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            HStack {
                                Image(systemName: "gift")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                                Text("\(nextRewardPoints) pts to next")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 23)
                        
                        Spacer(minLength: 35)
                        
                        VStack(spacing: 16) {
                            Button(action: {
                                if viewModel.isCycle4Completed {
                                    viewModel.startLongBreak()
                                } else {
                                    viewModel.startShortBreak()
                                }
                                dismiss()
                            }) {
                                HStack {
                                    Image(systemName: viewModel.isCycle4Completed ? "cup.and.saucer.fill" : "arrow.right.circle.fill")
                                    Text(viewModel.isCycle4Completed ? "Take a long Break" : "Take a short break")
                                }
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(viewModel.isCycle4Completed ? Color.orange : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                                .shadow(color: (viewModel.isCycle4Completed ? Color.orange : Color.blue).opacity(0.3), radius: 8, x: 0, y: 5)
                            }
                            
                            if viewModel.isCycle4Completed {
                                Button(action : {
                                    viewModel.skipBreakAndStartNewCycle()
                                    dismiss()
                                }) {
                                    Text("Skip break & Start a new cycle")
                                        .font(.subheadline.bold())
                                        .foregroundColor(.gray)
                                }
                                .padding(.bottom, 10)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                        
                    }
                }
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
        Double(viewModel.eggStage - 1) / 3.0
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

struct CoreStat: View {
    let value: String
    let label: String
    let icon: String
    let color: Color
    
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(color)
            Text(value)
                .font(.title2.bold())
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.8))
        .cornerRadius(24)
        .shadow(color: .gray.opacity(0.05), radius: 5)
    }
}

#Preview {
    ResultsView(viewModel: TimerViewModel())
}
