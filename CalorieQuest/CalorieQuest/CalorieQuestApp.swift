//
//  CalorieQuestApp.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/29/24.
//

import SwiftUI
import SwiftData

@main
struct CalorieQuestApp: App {
    
    init() {
        createDatabase()
        createScanFocusRegionImage()
    }
    
    @AppStorage("authenticationComplete") var authenticationComplete: Bool = false
    
    var body: some Scene {
        WindowGroup {
            AuthManager(authenticationComplete: $authenticationComplete)
                .preferredColorScheme(.light)
                .modelContainer(for: [Day.self, Tracked.self, Food.self, Nutrient.self, Video.self], isUndoEnabled: true)
        }
    }
}
