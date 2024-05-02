//
//  DatabaseResultsList.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
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

