//
//  DatabaseResultsList.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct DatabaseResultsList: View {
    let foodArray: [Food]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(foodArray, id: \.itemId) { aFood in
                    NavigationLink(destination: DatabaseResultsDetails(food: aFood)) {
                        DatabaseResultsItem(food: aFood)
                    }
                }
            }
            .navigationTitle("Database Search Results")
        }
        
        
    }
}

