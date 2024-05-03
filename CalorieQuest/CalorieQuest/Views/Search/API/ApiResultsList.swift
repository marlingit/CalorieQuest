//
//  ApiResultsList.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct ApiResultsList: View {
    var foodArray: [FoodStruct]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(foodArray, id: \.itemId) { aFood in
                    NavigationLink(destination: ApiResultsDetails(food: aFood)) {
                        ApiResultsItem(food: aFood)
                    }
                }
            }
            .navigationTitle("Nutritionix Search Results")
        }
        
    }
}
