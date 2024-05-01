//
//  CalorieQuestApp.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/29/24.
//

import SwiftUI

@main
struct CalorieQuestApp: App {
    
    init() {
        createScanFocusRegionImage()
    }
    
    @AppStorage("authenticationComplete") var authenticationComplete: Bool = false
    
    var body: some Scene {
        WindowGroup {
            AuthManager(authenticationComplete: $authenticationComplete)
                .preferredColorScheme(.light)
        }
    }
}
