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

class EggViewModel: ObservableObject {
    
    @Published var hatchedEggs: [HatchedEgg] = []{
        didSet  {
           saveEggs()
        }
    }
    // auto-derive count from the array rather than tracking separately
    @Published var totalEggsHatched: Int = 0
    
    init() {
            loadEggs()
        }
    
    func saveEggs() {
            if let encodedData = try? JSONEncoder().encode(hatchedEggs) {
                UserDefaults.standard.set(encodedData, forKey: "saved_eggs_key")
            }
        }
    
    func loadEggs() {
            if let savedData = UserDefaults.standard.data(forKey: "saved_eggs_key"),
               let decodedEggs = try? JSONDecoder().decode([HatchedEgg].self, from: savedData) {
                hatchedEggs = decodedEggs
            }
        }
    
   
    // called from ResultsView when a full cycle completes
    /*func addHatchedEgg(eggType: String) {
        let newEgg = HatchedEgg(
            eggType: eggType,
            nickname: "Egg #\(totalEggsHatched + 1)",
            dateHatched: Date()
        )
        hatchedEggs.append(newEgg)
        totalEggsHatched = hatchedEggs.count
    }*/
     
    
    func deleteEgg(at offsets: IndexSet) {
        hatchedEggs.remove(atOffsets: offsets)
    }
}
