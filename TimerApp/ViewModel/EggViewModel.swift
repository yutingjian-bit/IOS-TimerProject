//
//  EggViewModel.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import Foundation
import Combine
import SwiftUI

// model for a single fully hatched egg stored in the gallery
struct HatchedEgg: Identifiable {
    let id = UUID()
    var eggType: String
    var nickname: String
    var dateHatched: Date
}

class EggViewModel: ObservableObject {
    
    @Published var hatchedEggs: [HatchedEgg] = []
    // auto-derive count from the array rather than tracking separately
    @Published var totalEggsHatched: Int = 0
    
    
   
    // called from ResultsView when a full cycle completes
    func addHatchedEgg(eggType: String) {
        let newEgg = HatchedEgg(
            eggType: eggType,
            nickname: "Egg #\(totalEggsHatched + 1)",
            dateHatched: Date()
        )
        hatchedEggs.append(newEgg)
        totalEggsHatched = hatchedEggs.count
    }
    
    func deleteEgg(at offsets: IndexSet) {
        hatchedEggs.remove(atOffsets: offsets)
    }
}
