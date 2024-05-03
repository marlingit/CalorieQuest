/*
**********************************************************
*   Statement of Compliance with the Stated Honor Code   *
**********************************************************
I hereby declare on my honor and I affirm that
 
 (1) I have not given or received any unauthorized help on this assignment, and
 (2) All work is my own in this assignment.
 
I am hereby writing my name as my signature to declare that the above statements are true:
   
      Vijay Vadi, Brighton Young, and Marlin Spears
 
**********************************************************
 */
//
//  CalorieQuestApp.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
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
