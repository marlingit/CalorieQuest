//
//  CalorieQuestApp.swift
//  CalorieQuest
//
//  Created by Marlin on 4/25/24.
//

import SwiftUI
import SwiftData

@main
struct CalorieQuestApp: App {
    
    init (){
        
        createDatabase()
    }
    
    @AppStorage("darkMode") private var darkMode = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(darkMode ? .dark : .light)
                .modelContainer(for: [Day.self, Tracked.self, Meal.self, Food.self,  Nutrient.self, Video.self], isUndoEnabled: true)
        }
        
    }
}
